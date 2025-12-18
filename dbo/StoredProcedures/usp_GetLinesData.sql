CREATE PROCEDURE [dbo].[usp_GetLinesData]
AS
BEGIN
    SELECT [Id]
        ,[location].Lat AS Latitude
        ,[location].Long AS Longitude
        ,[LineCode]
    FROM [dbo].[Lines]
END