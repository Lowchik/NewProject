CREATE TABLE [dbo].[Marathon]
(
	[MarathonId] INT NOT NULL PRIMARY KEY, 
    [MarathonName] VARCHAR(50) NOT NULL, 
    [CityName] VARCHAR(50) NOT NULL,
	[CountryCode] int NOT NULL Foreign key references [Country] ([CountryCode]), 
    [YearHeld] VARCHAR(50) NOT NULL, 

)
