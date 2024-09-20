CREATE TABLE [dbo].[Volonteer]
(
	[VolonteerId] INT NOT NULL PRIMARY KEY, 
    [FirstName] VARCHAR(50) NOT NULL, 
    [LastName] VARCHAR(50) NOT NULL, 
    [CountryCode] int NOT NULL Foreign key references [Country] ([CountryCode]),
	[Gender] int NOT NULL Foreign key references [Gender] ([GenderId]) 
)
