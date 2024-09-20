CREATE TABLE [dbo].[Sponsorship]
(
	[SponsorshipId] INT NOT NULL PRIMARY KEY, 
    [SponsorName] VARCHAR(50) NOT NULL, 
    [RegistrationId] INT NOT NULL Foreign key references [Regisrtation] ([RegistrationId]),
)
