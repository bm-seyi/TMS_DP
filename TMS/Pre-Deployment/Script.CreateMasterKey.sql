-- Write your own SQL object definition here, and it'll be included in your package.
USE MASTER;
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    -- Create the master key if it doesn't exist
    CREATE MASTER KEY  ENCRYPTION BY PASSWORD = '$(masterKey)';
END
ELSE
BEGIN
    -- Alter the master key if it already exists
    ALTER MASTER KEY REGENERATE WITH ENCRYPTION BY PASSWORD = '$(masterKey)';
END
GO
