﻿CREATE TABLE [dbo].[User]
(
	[Email] VARCHAR(50) NOT NULL PRIMARY KEY, 
    [Password] VARCHAR(250) NOT NULL, 
    [FirstName] VARCHAR(50) NOT NULL, 
    [LastName] VARCHAR(50) NOT NULL, 
    [RoleId] INT NOT NULL Foreign key references [Role] ([RoleId])
)
