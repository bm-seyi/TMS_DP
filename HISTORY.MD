## 0.0.1
### Added
Created the [Action_Log](./TMS/dbo/Tables/Action_Log.sql) and [Lines](./TMS/dbo/Tables/Lines.sql) tables.


## 0.0.2
### Fixed/Updated
- Modified the ID column in [Lines](./TMS/dbo/Tables/Lines.sql), changing its data type from `INT` to `BIGINT` to enhance capacity.


## 0.0.3
### Added
- Added a new column, `OPM_ID`, to store node IDs retrieved from the OpenStreetMap API.

### Fixed/Updated
- Modified the ID column in [Lines](./TMS/dbo/Tables/Lines.sql), changing its data type from `BIGINT` to `UNIQUEIDENTIFIER`.

## 0.0.4
### Removed
- Removed the default value `newsequentialid` from the `ID` column.

## 0.0.5
### Added
- Implemented a [Post-Deployment](./TMS/Script.PostDeployment.sql) script to execute custom SQL commands following deployment.  
- Developed [Service_Broker](./TMS/Post-Deployment/Service_Broker.sql) script to activate Service Broker on the database.

## 0.0.6
### Fixed/Updated
- Updated [Script.PostDeployment](./TMS/Script.PostDeployment.sql) to use `\` instead of `/` for compatibility.
- Corrected [Service_Broker](./TMS/Post-Deployment/Service_Broker.sql) to properly enable the Service Broker.
