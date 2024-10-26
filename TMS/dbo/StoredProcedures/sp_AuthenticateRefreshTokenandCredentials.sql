CREATE PROCEDURE [dbo].[sp_AuthenticateRefreshTokenandCredentials]
    @ClientId UNIQUEIDENTIFIER,
    @hashedToken VARBINARY(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Combined query to fetch user and client details in one go
    DECLARE
            @refreshToken VARBINARY(256)

    SELECT 
    @refreshToken = [dbo].[Tokens].[encryptedToken]
    FROM [dbo].[Clients]
    LEFT JOIN [dbo].[Tokens] ON [Clients].[ID] = @ClientId
    WHERE [Tokens].[expiry] >= GETUTCDATE() AND [Tokens].[hashedToken] = @hashedToken

    -- Check if the user exists
    IF @refreshToken IS NULL
    BEGIN
        RETURN 1; -- Return 1 if no user found
    END

    -- Return the results
    SELECT 
        @refreshToken AS refreshToken
END

GO

