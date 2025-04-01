-- Create Message Type
IF NOT EXISTS (SELECT * FROM sys.service_message_types WHERE name = 'DataChangeMessage')
BEGIN
    CREATE MESSAGE TYPE DataChangeMessage VALIDATION = WELL_FORMED_XML;
END
GO

-- Create Contract
IF NOT EXISTS (SELECT * FROM sys.service_contracts WHERE name = 'DataChangeContract')
BEGIN
    CREATE CONTRACT DataChangeContract (DataChangeMessage SENT BY INITIATOR);
END
GO

-- Create Queue
IF NOT EXISTS (SELECT * FROM sys.service_queues WHERE name = 'DataChangeQueue')
BEGIN
    CREATE QUEUE DataChangeQueue;
END
GO

-- Create Service
IF NOT EXISTS (SELECT * FROM sys.services WHERE name = 'DataChangeService')
BEGIN
    CREATE SERVICE DataChangeService ON QUEUE DataChangeQueue (DataChangeContract);
END
GO
