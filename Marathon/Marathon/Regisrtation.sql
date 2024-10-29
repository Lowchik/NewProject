CREATE TABLE [dbo].[Regisrtation]
(
	[RegistrationId] INT NOT NULL PRIMARY KEY,
	[RannerId] INT NOT NULL Foreign key references [Runner] ([RunnerId]), 
    [RegistrationDateTime] DATETIME NOT NULL,
	[RaceKitOption] INT NOT NULL Foreign key references [RaceKitOption] ([RaceKitOptionId]),
	[RegistrationStatus] INT NOT NULL Foreign key references [RegistrationStatus] ([RegistrationStatusId]), 
    [Cost] FLOAT NOT NULL,
	[Charity] INT NOT NULL Foreign key references [Charity] ([CharityId]), 
    

	

)
