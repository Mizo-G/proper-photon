/* Insert User */
CREATE PROCEDURE [dbo].[InsertUser]
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Email VARCHAR(100),
    @PhoneNumber VARCHAR(32) = NULL,
    @Country NVARCHAR(100),
    @City NVARCHAR(200) = NULL,
    @IsMale BIT = 0,
    @Hash CHAR(48)
AS
BEGIN
    SET NOCOUNT ON;

    /* start docs
    {
        "description": "Insert a new user into the User table",
        "params": [
            { "Name": "@FirstName", "Type": "NVARCHAR(100)", "Default": null },
            { "Name": "@LastName", "Type": "NVARCHAR(100)", "Default": null },
            { "Name": "@Email", "Type": "VARCHAR(100)", "Default": null },
            { "Name": "@PhoneNumber", "Type": "VARCHAR(32)", "Default": "NULL" },
            { "Name": "@Country", "Type": "NVARCHAR(100)", "Default": null },
            { "Name": "@City", "Type": "NVARCHAR(200)", "Default": "NULL" },
            { "Name": "@IsMale", "Type": "Bit", "Default": "0" },
            { "Name": "@Hash", "Type": "CHAR(48)", "Default": null },
        ],
        "return": ["NewUserId"]
    }
    end docs */

    INSERT INTO [dbo].[User] (FirstName, LastName, Email, PhoneNumber, Country, City)
    VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Country, @City);

    DECLARE @NewUserId INT = SCOPE_IDENTITY();

    INSERT INTO [dbo].[UserDetails] (UserId, IsMale, Hash, CreatedDate, LastChangeDate, LastLoginAttempt, LastLoginDate, FailedLoginAttemptsCount)
    VALUES (@NewUserId, @IsMale, @Hash, GETUTCDATE(), GETUTCDATE(), NULL, NULL, 0);

    SELECT @NewUserId;
END;

GO

