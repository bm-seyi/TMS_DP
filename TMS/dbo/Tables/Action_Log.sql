CREATE TABLE [dbo].[Action_Log] (
    [ID]            UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [CreatedOn]     DATETIME2 (0)    NOT NULL,
    [Source]        VARCHAR (50)     NOT NULL,
    [Error_Message] NVARCHAR (MAX)   NULL,
    [Duration]      DECIMAL (8, 2)   NOT NULL,
    [ETL]           VARCHAR (14)     NOT NULL,
    [Status]        VARCHAR (9)      NOT NULL,
    [Group_ID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Action_Log] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [chk_ETL] CHECK ([ETL]='Load' OR [ETL]='Transform' OR [ETL]='Extract' OR [ETL]='Script'),
    CONSTRAINT [chk_Logdate] CHECK ([CreatedOn]<=getdate())
);


GO

CREATE NONCLUSTERED INDEX [Index_Action_Log_1]
    ON [dbo].[Action_Log]([CreatedOn] DESC);


GO

