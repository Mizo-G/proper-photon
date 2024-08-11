---
title: "[dbo].[InsertUser]"
description: "Insert a new user into the User table"
dbstatus: "✔️ Passing"
codestatus: "❌ Failing"
returns: 
  - "NewUserId"
params: 
  - "@FirstName NVARCHAR(100)"
  - "@LastName NVARCHAR(100)"
  - "@Email VARCHAR(100)"
  - "@PhoneNumber VARCHAR(32) = NULL"
  - "@Country NVARCHAR(100)"
  - "@City NVARCHAR(200) = NULL"
  - "@IsMale BIT = 0"
  - "@Hash CHAR(48)"
refs: 
  - "User"
  - "UserDetails"
createdby: "dbadmin"
---

## Title
**[dbo].[InsertUser]**

---

## Description
Insert a new user into the User table

---

## Status
- **Database Status**: <span style="color: green;">✔️ Passing</span>
- **Code Status**: <span style="color: red;">❌ Failing</span>

---

## Params
- **@FirstName**: `NVARCHAR(100)`, Default: `null`
- **@LastName**: `NVARCHAR(100)`, Default: `null`
- **@Email**: `VARCHAR(100)`, Default: `null`
- **@PhoneNumber**: `VARCHAR(32)`, Default: `null`
- **@Country**: `NVARCHAR(100)`, Default: `null`
- **@City**: `NVARCHAR(200)`, Default: `null`
- **@IsMale**: `BIT`, Default: `null`
- **@Hash**: `CHAR(48)`, Default: `null`

---


## Returns
- NewUserId

---


## References
- User
- UserDetails

---

## Code

<details>
<summary>SQL</summary>

~~~~sql
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

    

    INSERT INTO [dbo].[User] (FirstName, LastName, Email, PhoneNumber, Country, City)
    VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Country, @City);

    DECLARE @NewUserId INT = SCOPE_IDENTITY();

    INSERT INTO [dbo].[UserDetails] (UserId, IsMale, Hash, CreatedDate, LastChangeDate, LastLoginAttempt, LastLoginDate, FailedLoginAttemptsCount)
    VALUES (@NewUserId, @IsMale, @Hash, GETUTCDATE(), GETUTCDATE(), NULL, NULL, 0);

    SELECT @NewUserId;
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
