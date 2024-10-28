-- Write your own SQL object definition here, and it'll be included in your package.
-- Pre-Deployment Script for Asymmetric Key and Login
USE MASTER;
-- Check if the asymmetric key exists
IF NOT EXISTS (SELECT * FROM sys.asymmetric_keys WHERE name = 'AssembleyKey')
BEGIN
    -- Create the asymmetric key if it doesn't exist
    CREATE ASYMMETRIC KEY AssembleyKey
    WITH ALGORITHM = RSA_2048;
END
GO

-- Check if the login from the asymmetric key exists
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'AssembleyKeyLogin')
BEGIN
    -- Create the login from the asymmetric key if it doesn't exist
    CREATE LOGIN AssembleyKeyLogin FROM ASYMMETRIC KEY AssembleyKey;
END
GO
