CREATE PROCEDURE [dbo].[sp_AuthenticateUserAndClient]
    @Email NVARCHAR(100),
    @ClientId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Combined query to fetch user and client details in one go
    DECLARE @UserPwdHash VARBINARY(256),
            @UserSalt VARBINARY(256),
            @ClientSecret VARBINARY(256),
            @ClientIV VARBINARY(256);

    -- Fetch both user and client data using a single query with LEFT JOIN
    SELECT 
        @UserPwdHash = u.[pwdhash], 
        @UserSalt = u.[salt],
        @ClientSecret = c.[secret], 
        @ClientIV = c.[iv]
    FROM [dbo].[hashed] u
    LEFT JOIN [dbo].[Clients] c
    ON c.[ID] = @ClientId
    WHERE u.[email] = @Email;

    -- Check if the user exists
    IF @UserPwdHash IS NULL
    BEGIN
        RETURN 1; -- Return 1 if no user found
    END

    -- Check if the client exists
    IF @ClientSecret IS NULL
    BEGIN
        RETURN 2; -- Return 2 if no client found
    END

    -- Return the results
    SELECT 
        @UserPwdHash AS PwdHash,
        @UserSalt AS Salt,
        @ClientSecret AS ClientSecret,
        @ClientIV AS ClientIV;

END

GO

