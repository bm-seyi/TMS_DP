CREATE TABLE [dbo].[Lines]
(
  [Id] UNIQUEIDENTIFIER PRIMARY KEY,
  [OPM_Id] BIGINT NOT NULL,
  [latitude] DECIMAL(9,7) NOT NULL,
  [longitude] DECIMAL(8,7) NOT NULL,
  [LineCode] CHAR(3) NOT NULL,
  [LogId] UNIQUEIDENTIFIER NOT NULL
  CONSTRAINT [chk_LineCode] CHECK(LEN([LineCode]) = 3)
)
GO

CREATE TRIGGER trg_DataChangeNotification
ON [dbo].[Lines]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @message XML;
    DECLARE @operationType NVARCHAR(10);
    DECLARE @affectedIDs XML;

    -- Determine the operation type and capture affected IDs
    IF EXISTS (SELECT 1 FROM INSERTED)
    BEGIN
        IF EXISTS (SELECT 1 FROM DELETED)
        BEGIN
            -- Update: Capture the IDs of the rows that were updated
            SET @operationType = 'UPDATE';

            -- Get the IDs from the INSERTED table (all updated rows)
            SET @affectedIDs = 
                (SELECT [Id] FROM INSERTED FOR XML PATH('AffectedID'));
        END
        ELSE
        BEGIN
            -- Insert: Only the inserted rows are affected
            SET @operationType = 'INSERT';
            SET @affectedIDs = 
                (SELECT [Id] FROM INSERTED FOR XML PATH('AffectedID'));
        END
    END
    ELSE IF EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        -- Delete: Only the deleted rows are affected
        SET @operationType = 'DELETE';
        SET @affectedIDs = 
            (SELECT [Id] FROM DELETED FOR XML PATH('AffectedID'));
    END

    -- Create the message with the operation type and affected IDs
    SET @message = 
        (SELECT 
            @operationType AS OperationType,
            GETDATE() AS ChangeTime,
            @affectedIDs AS AffectedIDs
         FOR XML PATH('Notification'), ROOT('DataChangeNotification'));

    -- Start a conversation
    DECLARE @dialog_handle UNIQUEIDENTIFIER;
    BEGIN TRANSACTION;
    
    BEGIN DIALOG @dialog_handle 
        FROM SERVICE [DataChangeService]
        TO SERVICE 'DataChangeService'
        ON CONTRACT [DataChangeContract]
        WITH ENCRYPTION = OFF;

    -- Send message to queue
    SEND ON CONVERSATION @dialog_handle 
    MESSAGE TYPE DataChangeMessage (@message);

    -- End the conversation
    END CONVERSATION @dialog_handle;

    COMMIT TRANSACTION;
END;

