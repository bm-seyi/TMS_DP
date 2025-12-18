CREATE TABLE [dbo].[Lines]
(
    [Id] UNIQUEIDENTIFIER DEFAULT(NEWSEQUENTIALID()) NOT NULL,
    [OpenStreetMapsId] VARCHAR(255) NOT NULL,
    [Location] GEOGRAPHY NOT NULL,
    [LineCode] CHAR(3) NOT NULL,
    CONSTRAINT [Pk_Lines] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [Chk_LineCode_Lines] CHECK(LEN([LineCode]) = 3),
    CONSTRAINT [Uqe_OpenStreetMapsId] UNIQUE ([OpenStreetMapsId])
)
GO