CREATE TABLE [dbo].[Clients] (
    [ID]        UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn] DATETIME2 (0)    DEFAULT (getutcdate()) NOT NULL,
    [name]      VARCHAR (50)     NOT NULL,
    [secret]    VARBINARY (MAX)  NOT NULL,
    CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO

