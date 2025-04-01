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

## 0.0.7
### Added
- New columns `[Project]`, `[Type]`, and `[Content]` to the `ActionLog` table.
- New `CHECK` constraints: `[chk_Type]` for `Type` column and `[chk_Status]` for `Status` column.

### Fixed / Updated
- Renamed table `Action_Log` to `ActionLog`.
- Renamed column `[ID]` to `[Id]`, `[ETL]` to `[Content]`, and `[Group_ID]` to `[GroupId]` for consistency.
- Updated `CHECK` constraint on `Status` to ensure values are limited to `'Success'` and `'Fail'`.
- Updated non-clustered index name from `Index_Action_Log_1` to `Idx_ActionLog_CreatedOn`.
- Commented out `:r .\Post-Deployment\Service_Broker.sql` in `Script.PostDeployment.sql`.

### Removed
- Dropped `Source` column from `ActionLog` table.
- Removed outdated `CHECK` constraint `[chk_ETL]` on the `ETL` column.

## 0.1.0
### Added
- **New DataChangeQueue and Associated Components**  
  - Created a new `DataChangeQueue.sql` script to define Service Broker components such as:
    - `Message Type`: `DataChangeMessage`
    - `Contract`: `DataChangeContract`
    - `Queue`: `DataChangeQueue`
    - `Service`: `DataChangeService`
  
- **Lines Table Trigger for Data Change Notification**  
  - Added a trigger `trg_DataChangeNotification` to send notifications for changes (insert, update, delete) in the `Lines` table using the Service Broker.

### Fixed/Updated
- **Lines Table**  
  - Corrected column naming conventions for consistency with camelCase (e.g., `OPM_ID` -> `OPM_Id`, `LogID` -> `LogId`).

- **New Post-Deployment Script (`Script.PostDeployment.sql`)**  
  - Updated the post-deployment script to include the new `Service_Broker.sql` script and a new `DataChangeQueue.sql` script.

- **Post-Deployment Script (`Script.PostDeployment.sql`)**  
  - Fixed the inclusion of `Service_Broker.sql` to properly reference it with `GO` statements for execution separation.

- **TMS SQL Project (`TMS.sqlproj`)**  
  - Updated the project file to include the new `DataChangeQueue.sql` in the deployment process.

- **Post-Deployment Service Broker Script**  
  - Introduced checks for the existence of Service Broker and ensured it is enabled only if it's disabled.