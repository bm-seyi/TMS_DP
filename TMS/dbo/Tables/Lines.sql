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
    SET NOCOUNT ON;
    
    DECLARE @message XML;
    DECLARE @operationType NVARCHAR(10);
    DECLARE @affectedIDs XML;
    DECLARE @dialog_handle UNIQUEIDENTIFIER;

    -- Determine operation type
    SELECT @operationType = CASE
        WHEN EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED) THEN 'UPDATE'
        WHEN EXISTS (SELECT 1 FROM INSERTED) THEN 'INSERT'
        WHEN EXISTS (SELECT 1 FROM DELETED) THEN 'DELETE'
        ELSE NULL
    END;

    IF @operationType IS NULL
        RETURN; -- No rows affected

    -- Build affected IDs XML
    IF @operationType IN ('INSERT', 'UPDATE')
        SET @affectedIDs = (
            SELECT [Id] AS [ID]
            FROM INSERTED
            FOR XML PATH(''), ROOT('AffectedIDs')
        );
    ELSE
        SET @affectedIDs = (
            SELECT [Id] AS [ID]
            FROM DELETED
            FOR XML PATH(''), ROOT('AffectedIDs')
        );

    -- Construct the full message using modern XML construction
    SET @message = (
        SELECT
            @operationType AS [OperationType],
            SYSDATETIME() AS [ChangeTimeUTC],
            @affectedIDs
        FOR XML PATH('Notification'), ROOT('DataChangeNotification')
    );

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Start and send message
        BEGIN DIALOG @dialog_handle 
            FROM SERVICE [DataChangeService]
            TO SERVICE 'DataChangeService'
            ON CONTRACT [DataChangeContract]
            WITH ENCRYPTION = OFF, LIFETIME = 3600;

        SEND ON CONVERSATION @dialog_handle 
            MESSAGE TYPE [DataChangeMessage] (@message);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Re-throw the error
        THROW;
    END CATCH
END;