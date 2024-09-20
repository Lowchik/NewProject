CREATE TABLE [dbo].[Staff]
(
	[StaffId] INT NOT NULL PRIMARY KEY, 
    [FirstName] VARCHAR(20) NOT NULL, 
    [LastName] VARCHAR(20) NOT NULL, 
    [DateOfBirth] DATE NOT NULL, 
    [Gender] CHAR(10) NOT NULL, 
    [PositionId] int not NULL foreign key references [Position] ([PositionId]), 
    [Email] VARCHAR(50) NOT NULL, 
    [Comments] VARCHAR(50) NOT NULL,
)
