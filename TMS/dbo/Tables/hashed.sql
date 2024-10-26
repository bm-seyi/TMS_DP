CREATE TABLE [dbo].[hashed] (
    [ID]      UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [email]   NVARCHAR (255)   NOT NULL,
    [pwdhash] VARBINARY (64)   NOT NULL,
    [salt]    VARBINARY (64)   NOT NULL,
    CONSTRAINT [pk_ID] PRIMARY KEY CLUSTERED ([ID] DESC),
    CONSTRAINT [CHK_ValidEmail] CHECK ([email] like '%_@__%.__%'),
    UNIQUE NONCLUSTERED ([email] ASC)
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_email_unique]
    ON [dbo].[hashed]([email] ASC);


GO

