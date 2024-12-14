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