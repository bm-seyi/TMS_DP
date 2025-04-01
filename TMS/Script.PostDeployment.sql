-- This file contains SQL statements that will be executed after the build script.
:r .\Post-Deployment\Service_Broker.sql
GO

:r .\Post-Deployment\DataChangeQueue.sql
GO