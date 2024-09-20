CREATE TABLE [dbo].[Event]
(
	[EventId] INT NOT NULL PRIMARY KEY, 
    [EventName] VARCHAR(50) NOT NULL,
	[EventTypeId] int NOT NULL Foreign key references [EventType] ([EventTypeId]), 
    [MarathonId] int NOT NULL Foreign key references [Marathon] ([MarathonId]), 
    [StartDateTime] DATETIME NOT NULL, 
    [Cost] FLOAT NOT NULL, 
    [MaxParticipants] INT NOT NULL, 
	

)
