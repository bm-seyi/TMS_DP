USE [TMS];

IF OBJECT_ID(N'dbo.HashPassword', N'FN') IS NOT NULL
    DROP FUNCTION dbo.HashPassword;
GO
CREATE FUNCTION dbo.HashPassword(@password NVARCHAR(4000), @salt VARBINARY(128))
RETURNS VARBINARY(64)
AS EXTERNAL NAME [TmsAuthClr].[tms_auth_clr.SecurityUtils].[HashPassword];
GO

IF OBJECT_ID(N'dbo.EncryptPlainText', N'FN') IS NOT NULL
    DROP FUNCTION dbo.EncryptPlainText;
GO
CREATE FUNCTION dbo.EncryptPlainText(@plaintext NVARCHAR(4000), @key VARBINARY(32))
RETURNS VARBINARY(MAX)
AS EXTERNAL NAME [TmsAuthClr].[tms_auth_clr.SecurityUtils].[EncryptPlainText];
GO

IF OBJECT_ID(N'dbo.DecryptPlainText', N'FN') IS NOT NULL
    DROP FUNCTION dbo.DecryptPlainText;
GO
CREATE FUNCTION dbo.DecryptPlainText(@ciphertext VARBINARY(MAX), @key VARBINARY(32))
RETURNS NVARCHAR(4000)
AS EXTERNAL NAME [TmsAuthClr].[tms_auth_clr.SecurityUtils].[DecryptPlainText];
GO
