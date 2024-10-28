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
- Developed a [post-development script](./TMS/Post%20Development/Script.AddAssemblies.sql) to include the necessary assemblies for executing the main `TmsAuthClr` assembly.

### Notes
- Created a post-development folder to organize scripts that enhance the project's maintainability.
- Included comments to ignore `DS224000` since it cannot be resolved. However, all added assemblies are confined to the "safe" permission set.

## 0.0.4
### Added
-  Developed a [post-development script](./TMS/Post%20Development/Script.AddFunctions.sql) to include the necessary functions for executing the methods within tms_auth_clr CLR.

### Removed
- Removed unnecessary code workspace.

## 0.1.0
### Added
- Established a Pre-Deployment directory to organize all pre-deployment scripts.
- Added [Script.PostOrchestrator.sql](./TMS/Script.PostOrchestrator.sql) and [Script.PreOrchestrator.sql](./TMS/Script.PreOrchestrator.sql) to manage and execute scripts in their designated folders.
- Introduced .gitignore to prevent sensitive information from being uploaded to the cloud repository.

### Fixed
- Renamed the Post Development folder to [Post-Deployment](./TMS/Post-Deployment/).

### Notes
- Excluded bin and 
obj folder files from tracking, as they are unnecessary for project builds and could pose security risks due to embedded passwords in sqlcmd variables.
- Future updates will aim to reduce the number of `<ItemGroup/>` entries within [TMS.sqlproj](./TMS/TMS.sqlproj).
- [Script.AddAssemblies.sql](./TMS/Post-Deployment/Script.AddAssemblies.sql) and [Script.AddFunctions.sql](./TMS/Post-Deployment/Script.AddFunctions.sql) have been commented out; further configuration is required and will be included in the next commit.
- Project uses Publish Profile to manage sqlcmd variables.