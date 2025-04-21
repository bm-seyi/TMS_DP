CREATE PROCEDURE [dbo].[ProcessDataChangeQueueMessage]
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @conversation_handle UNIQUEIDENTIFIER;
    DECLARE @message_body NVARCHAR(MAX);
    DECLARE @message_xml XML;
    DECLARE @operation_type NVARCHAR(50);
    
    DECLARE @affected_ids TABLE (ID UNIQUEIDENTIFIER);
    DECLARE @line_data TABLE (
        ID UNIQUEIDENTIFIER,
        Latitude FLOAT,
        Longitude FLOAT,
        ChangeType NVARCHAR(10)
    );
    
    WAITFOR (
        RECEIVE TOP (1)
            @conversation_handle = conversation_handle,
            @message_body = message_body
        FROM DataChangeQueue
    ), TIMEOUT 10000;
    
    IF @conversation_handle IS NULL OR @message_body IS NULL
        RETURN;
    
    SET @message_xml = TRY_CAST(@message_body AS XML);
    
    IF @message_xml IS NULL
    BEGIN
        IF @conversation_handle IS NOT NULL
            END CONVERSATION @conversation_handle WITH ERROR = 1 DESCRIPTION = 'Invalid XML message';
        
        RETURN;
    END
    
    -- Extract data using modern XML methods
    SET @operation_type = @message_xml.value('(/DataChangeNotification/Notification/OperationType)[1]', 'NVARCHAR(10)');
    
    -- Populate affected IDs using nodes() method
    INSERT INTO @affected_ids (ID)
    SELECT x.ID.value('.', 'UNIQUEIDENTIFIER')
    FROM @message_xml.nodes('/DataChangeNotification/Notification/AffectedIDs/ID') AS x(ID);
    
    -- Process based on operation type
    IF @operation_type = 'DELETE'
    BEGIN
        -- For DELETE, return just the IDs with operation type
        INSERT INTO @line_data (ID, ChangeType)
        SELECT ID, 'DELETE' FROM @affected_ids;
    END
    ELSE -- INSERT or UPDATE
    BEGIN
        -- For INSERT/UPDATE, return full line data with operation type
        INSERT INTO @line_data (ID, Latitude, Longitude, ChangeType)
        SELECT 
            [Lines].[Id], 
            [Lines].[latitude], 
            [Lines].[longitude],
            @operation_type
        FROM [dbo].[Lines]
        INNER JOIN @affected_ids a ON [Lines].[Id] = a.ID;
    END
    
    -- Return consolidated results
    SELECT 
        [ID],
        [Latitude],
        [Longitude],
        [ChangeType]
    FROM @line_data;
    
    -- Clean up conversation
    IF @conversation_handle IS NOT NULL
        END CONVERSATION @conversation_handle;
END