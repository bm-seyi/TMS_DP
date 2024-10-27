## 0.0.1
First development version

## 0.0.2
### Added
- Introduced a [post-deployment script](./TMS/Script.EnableClrIntegration.sql) to activate CLR.

### Fixed
- Corrected the casing of the clientID in the left join within the [sp_AuthenticateRefreshTokenandCredentials](./TMS/dbo/StoredProcedures/sp_AuthenticateRefreshTokenandCredentials.sql).

### Removed
- Eliminated all references to the IV column in both the [sp_AuthenticateRefreshTokenandCredentials](./TMS/dbo/StoredProcedures/sp_AuthenticateRefreshTokenandCredentials.sql) and [sp_AuthenticateUserAndClient](./TMS/dbo/StoredProcedures/sp_AuthenticateUserAndClient.sql).

### Notes
-  New files have been generated as a result of the build and publish process.

## 0.0.3
### Added
- Developed a [post-development script](./TMS/Script.AddAssemblies.sql) to include the necessary assemblies for executing the main `TmsAuthClr` assembly.

### Notes
- Created a post-development folder to organize scripts that enhance the project's maintainability.
- Included comments to ignore `DS224000` since it cannot be resolved. However, all added assemblies are confined to the "safe" permission set.