CREATE TABLE [dbo].[Runner]
(
	[RunnerId] INT NOT NULL PRIMARY KEY, 
	[Email] VARCHAR(50) NOT NULL Foreign key references [User] ([Email]), 
    [Gender] int not NULL foreign key references [Gender] ([GenderId]),  
    [DateOfBirth] DATE NULL,
	[CountryCode] int NOT NULL Foreign key references [Country] ([CountryCode]), 
)
