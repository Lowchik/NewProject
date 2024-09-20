CREATE TABLE [dbo].[Timesheet]
(
	[TimesheetId] INT NOT NULL PRIMARY KEY, 
    [StaffId] int NOT NULL foreign key references [Staff] ([StaffId]), 
    [StartDateTime] DATETIME NOT NULL, 
    [EndDateTime] DATETIME NOT NULL, 
    [PayAmount] VARCHAR(50) NOT NULL, 
)
