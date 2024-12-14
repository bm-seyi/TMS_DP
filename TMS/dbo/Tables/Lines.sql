CREATE TABLE [dbo].[Lines]
(
  [ID] INT NOT NULL PRIMARY KEY,
  [latitude] DECIMAL(9,7) NOT NULL,
  [longitude] DECIMAL(8,7) NOT NULL,
  [LineCode] CHAR(3) NOT NULL,
  [LogID] UNIQUEIDENTIFIER NOT NULL
  CONSTRAINT [chk_LineCode] CHECK(LEN([LineCode]) = 3)
)
