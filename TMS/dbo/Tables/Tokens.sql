CREATE TABLE [dbo].[Tokens] (
    [ID]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [CreatedOn]      DATETIME2 (0)    DEFAULT (getutcdate()) NOT NULL,
    [client_id]      UNIQUEIDENTIFIER NOT NULL,
    [encryptedToken] VARBINARY (96)   NOT NULL,
    [expiry]         DATETIME2 (0)    NOT NULL,
    [hashedToken]    VARBINARY (32)   NOT NULL,
    CONSTRAINT [PK_Tokens] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Tokens_Clients] FOREIGN KEY ([client_id]) REFERENCES [dbo].[Clients] ([ID]),
    CONSTRAINT [unique_encryptedtoken] UNIQUE NONCLUSTERED ([encryptedToken] ASC),
    CONSTRAINT [unique_hashedtoken] UNIQUE NONCLUSTERED ([hashedToken] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_Tokens_ClientId]
    ON [dbo].[Tokens]([client_id] ASC);


GO

