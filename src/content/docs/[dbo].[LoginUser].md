---
title: "[dbo].[LoginUser]"
description: "Log in a user by verifying email and hash, and update login attempts and dates. Returns the logged in User or Null."
dbstatus: "✔️ Passing"
codestatus: "❌ Failing"
returns: 
  - "Id"
  - "FirstName"
  - "LastName"
  - "Email"
  - "PhoneNumber"
  - "Country"
  - "City"
  - "IsActive"
  - "IsBlocked"
params: 
  - "@Email VARCHAR(100)"
  - "@Hash CHAR(64)"
refs: 
  - "User"
  - "UserDetails"
createdby: "dbadmin"
---

## Title
**[dbo].[LoginUser]**

---

## Description
Log in a user by verifying email and hash, and update login attempts and dates. Returns the logged in User or Null.

---

## Status
- **Database Status**: <span style="color: green;">✔️ Passing</span>
- **Code Status**: <span style="color: red;">❌ Failing</span>

---

## Params
- **@Email**: `VARCHAR(100)`, Default: `null`
- **@Hash**: `CHAR(64)`, Default: `null`

---


## Returns
- Id
- FirstName
- LastName
- Email
- PhoneNumber
- Country
- City
- IsActive
- IsBlocked

---


## References
- User
- UserDetails

---

## Code

<details>
<summary>SQL</summary>

~~~~sql
CREATE   PROCEDURE [dbo].[LoginUser]
    @Email VARCHAR(100),
    @Hash CHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserId INT;
    DECLARE @CurrentDateTime DATETIME2 = GETUTCDATE();
    
    

    
    SELECT @UserId = u.Id
    FROM [dbo].[User] u
    INNER JOIN [dbo].[UserDetails] ud ON u.Id = ud.UserId
    WHERE u.Email = @Email AND ud.Hash = @Hash AND u.IsArchived = 0;

    IF @UserId IS NOT NULL
    BEGIN
        
        UPDATE [dbo].[UserDetails]
        SET LastLoginDate = @CurrentDateTime,
            LastLoginAttempt = @CurrentDateTime,
            FailedLoginAttemptsCount = 0
        WHERE UserId = @UserId;

        SELECT 
            u.Id,
            u.FirstName,
            u.LastName,
            u.Email,
            u.PhoneNumber,
            u.Country,
            u.City,
            u.IsActive,
            u.IsBlocked
        FROM [dbo].[User] u
        WHERE u.Id = @UserId AND u.IsArchived = 0;
    END
    ELSE
    BEGIN
        
        UPDATE [dbo].[UserDetails]
        SET LastLoginAttempt = @CurrentDateTime,
            FailedLoginAttemptsCount = FailedLoginAttemptsCount + 1
        WHERE EXISTS (SELECT 1 FROM [dbo].[User] u
                      INNER JOIN [dbo].[UserDetails] ud ON u.Id = ud.UserId
                      WHERE u.Email = @Email);
    END
END;
GO 
~~~~
</details>

<details>
<summary>C#</summary>

~~~~cs
code coming soon...
~~~~
</details>
