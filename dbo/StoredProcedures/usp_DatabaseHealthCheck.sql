CREATE PROCEDURE [dbo].[usp_DatabaseHealthCheck]
AS
SELECT [name] AS [DatabaseName], [state_desc] AS [Status]
FROM sys.databases
WHERE [name] = DB_NAME();