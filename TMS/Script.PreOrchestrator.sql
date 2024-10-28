-- This file contains SQL statements that will be executed before the build script.

-- Reference the script to create a master key.
:r .\Pre-Deployment\Script.CreateMasterKey.sql

-- Reference the script to create key and login for assemblies.
:r .\Pre-Deployment\Script.CreateAssembleyKey.sql