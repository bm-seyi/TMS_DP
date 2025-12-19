CREATE PROCEDURE [dbo].[usp_opm_lines]
AS
BEGIN
  SET NOCOUNT ON;
  SET XACT_ABORT ON;
    
  BEGIN TRY
    IF OBJECT_ID('tempdb..#temp') IS NOT NULL
      BEGIN

        MERGE INTO [dbo].[Lines] AS TARGET
        USING #temp AS source
        ON TARGET.[OpenStreetMapsId] = source.[id]
        WHEN MATCHED THEN
            UPDATE SET
                TARGET.[Location] = geography::Point(source.[lat], source.[lon], 4326),
                TARGET.[LineCode] = source.[LineCode]
                
        WHEN NOT MATCHED BY TARGET THEN
          INSERT ([OpenStreetMapsId], [Location], [LineCode])
          VALUES ([id], geography::Point(source.[lat], source.[lon], 4326), [LineCode]);
      END
    ELSE
      BEGIN
        RAISERROR('Temporary table #temp does not exist.', 16, 1);
      END 
  END TRY
  BEGIN CATCH
   THROW
  END CATCH
    
RETURN 0;
END;