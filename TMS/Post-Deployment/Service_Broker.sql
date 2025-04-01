-- Batch 1: Switch to single-user mode with rollback immediate
ALTER DATABASE TMS SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

GO

-- Batch 2: Enable Service Broker
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TMS' AND is_broker_enabled = 0)
BEGIN
    ALTER DATABASE TMS SET ENABLE_BROKER;
END

GO

-- Batch 3: Switch back to multi-user mode
ALTER DATABASE TMS SET MULTI_USER;

GO
