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