-- This file contains SQL statements that will be executed after the build script.
-- Enable CLR integration
USE MASTER;
IF (SELECT value_in_use FROM sys.configurations WHERE name = 'clr enabled') = 0
BEGIN
    EXEC sp_configure 'show advanced options', 1; -- DevSkim: ignore DS224000
    RECONFIGURE;
    EXEC sp_configure 'clr enabled', 1; -- DevSkim: ignore DS224000
    RECONFIGURE;
END
