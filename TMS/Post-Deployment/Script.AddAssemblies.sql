-- This file contains SQL statements that will be executed after the build script.
-- Create or alter assembly
BEGIN TRY
    -- Register or alter System.Runtime
    ALTER ASSEMBLY [System.Runtime]
    FROM '/sqlserver/assemblies/System.Runtime.dll'
    WITH PERMISSION_SET = SAFE;
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 15151  -- Error number for assembly not found
    BEGIN
        CREATE ASSEMBLY [System.Runtime]
        FROM '/sqlserver/assemblies/System.Runtime.dll'
        WITH PERMISSION_SET = SAFE;
    END
END CATCH;

BEGIN TRY
    -- Register or alter System.Security
    ALTER ASSEMBLY [System.Security]
    FROM '/sqlserver/assemblies/System.Security.dll'
    WITH PERMISSION_SET = SAFE;
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 15151  -- Error number for assembly not found
    BEGIN
        CREATE ASSEMBLY [System.Security]
        FROM '/sqlserver/assemblies/System.Security.dll'
        WITH PERMISSION_SET = SAFE;
    END
END CATCH;

BEGIN TRY
    -- Register or alter System.Security.Cryptography
    ALTER ASSEMBLY [System.Security.Cryptography]
    FROM '/sqlserver/assemblies/System.Security.Cryptography.dll'
    WITH PERMISSION_SET = SAFE;
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 15151  -- Error number for assembly not found
    BEGIN
        CREATE ASSEMBLY [System.Security.Cryptography]
        FROM '/sqlserver/assemblies/System.Security.Cryptography.dll'
        WITH PERMISSION_SET = SAFE;
    END
END CATCH;

BEGIN TRY
    -- Register or alter Microsoft.SqlServer.Server
    ALTER ASSEMBLY [Microsoft.SqlServer.Server]
    FROM '/sqlserver/assemblies/Microsoft.SqlServer.Server.dll'
    WITH PERMISSION_SET = SAFE;
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 15151  -- Error number for assembly not found
    BEGIN
        CREATE ASSEMBLY [Microsoft.SqlServer.Server]
        FROM '/sqlserver/assemblies/Microsoft.SqlServer.Server.dll'
        WITH PERMISSION_SET = SAFE;
    END
END CATCH;

BEGIN TRY
    -- Register or alter Konscious.Security.Cryptography
    ALTER ASSEMBLY [Konscious.Security.Cryptography]
    FROM '/sqlserver/assemblies/Konscious.Security.Cryptography.dll'
    WITH PERMISSION_SET = SAFE;
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 15151  -- Error number for assembly not found
    BEGIN
        CREATE ASSEMBLY [Konscious.Security.Cryptography]
        FROM '/sqlserver/assemblies/Konscious.Security.Cryptography.dll'
        WITH PERMISSION_SET = SAFE;
    END
END CATCH;

BEGIN TRY
    -- Register or alter TmsAuthClr
    ALTER ASSEMBLY [TmsAuthClr]
    FROM '/sqlserver/securityAssembly/TmsAuthClr.dll'
    WITH PERMISSION_SET = SAFE;
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 15151  -- Error number for assembly not found
    BEGIN
        CREATE ASSEMBLY [TmsAuthClr]
        FROM '/sqlserver/securityAssembly/TmsAuthClr.dll'
        WITH PERMISSION_SET = SAFE;
    END
END CATCH;
