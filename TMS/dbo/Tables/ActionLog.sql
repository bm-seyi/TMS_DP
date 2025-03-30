CREATE TABLE [dbo].[ActionLog] (
    [Id]            UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [CreatedOn]     DATETIME2 (0)    NOT NULL,
    [Project]       VARCHAR (50)     NOT NULL,
    [Type]          VARCHAR (50)     NOT NULL,
    [Error_Message] NVARCHAR (MAX)   NULL,
    [Duration]      DECIMAL (8, 2)   NOT NULL,
    [Content]       VARCHAR (14)     NOT NULL,
    [Status]        VARCHAR (9)      NOT NULL,
    [GroupId]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Action_Log] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [chk_Type] CHECK ([Type] IN ('Container', 'Function')),
    CONSTRAINT [chk_Status] CHECK ([Status] IN ('Success', 'Fail')),
    CONSTRAINT [chk_Logdate] CHECK ([CreatedOn]<=getdate())
);


GO

CREATE NONCLUSTERED INDEX [Idx_ActionLog_CreatedOn]
    ON [dbo].[ActionLog] ([CreatedOn]);


GO
