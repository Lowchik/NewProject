CREATE TABLE [dbo].[Registration_Envent]
(
	[RegistrationEventId] INT NOT NULL PRIMARY KEY,
	[RegistrationId] INT NOT NULL Foreign key references [Regisrtation] ([RegistrationId]),
	[EventId] INT NOT NULL Foreign key references [Event] ([EventId]), 
    [BibNumber] INT NOT NULL, 
    [RaceTime] FLOAT NOT NULL,

)
