/*
Скрипт развертывания для Marathon

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Marathon"
:setvar DefaultFilePrefix "Marathon"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Идет создание базы данных $(DatabaseName)…'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Идет создание Таблица [dbo].[Charity]…';


GO
CREATE TABLE [dbo].[Charity] (
    [CharityId]          INT           NOT NULL,
    [ChatityName]        VARCHAR (50)  NOT NULL,
    [CharityDescription] VARCHAR (MAX) NOT NULL,
    [CharityLogo]        VARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([CharityId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Country]…';


GO
CREATE TABLE [dbo].[Country] (
    [CountryCode] INT          NOT NULL,
    [CountryName] VARCHAR (50) NOT NULL,
    [CountyFlag]  VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CountryCode] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Event]…';


GO
CREATE TABLE [dbo].[Event] (
    [EventId]         INT          NOT NULL,
    [EventName]       VARCHAR (50) NOT NULL,
    [EventTypeId]     INT          NOT NULL,
    [MarathonId]      INT          NOT NULL,
    [StartDateTime]   DATETIME     NOT NULL,
    [Cost]            FLOAT (53)   NOT NULL,
    [MaxParticipants] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([EventId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[EventType]…';


GO
CREATE TABLE [dbo].[EventType] (
    [EventTypeId]   INT          NOT NULL,
    [EventTypeName] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([EventTypeId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Gender]…';


GO
CREATE TABLE [dbo].[Gender] (
    [GenderId] INT        NOT NULL,
    [Gender]   NCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([GenderId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Marathon]…';


GO
CREATE TABLE [dbo].[Marathon] (
    [MarathonId]   INT          NOT NULL,
    [MarathonName] VARCHAR (50) NOT NULL,
    [CityName]     VARCHAR (50) NOT NULL,
    [CountryCode]  INT          NOT NULL,
    [YearHeld]     NCHAR (10)   NOT NULL,
    PRIMARY KEY CLUSTERED ([MarathonId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Position]…';


GO
CREATE TABLE [dbo].[Position] (
    [PositionId]          INT           NOT NULL,
    [PositionName]        VARCHAR (30)  NOT NULL,
    [PositionDescription] VARCHAR (MAX) NOT NULL,
    [PayPeriod]           VARCHAR (50)  NOT NULL,
    [PayRate]             INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([PositionId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[RaceKitOption]…';


GO
CREATE TABLE [dbo].[RaceKitOption] (
    [RaceKitOptionId] INT          NOT NULL,
    [RaceKitIption]   VARCHAR (50) NOT NULL,
    [Cost]            FLOAT (53)   NOT NULL,
    PRIMARY KEY CLUSTERED ([RaceKitOptionId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Regisrtation]…';


GO
CREATE TABLE [dbo].[Regisrtation] (
    [RegistrationId]       INT        NOT NULL,
    [RannerId]             INT        NOT NULL,
    [RegistrationDateTime] DATETIME   NOT NULL,
    [RaceKitOption]        INT        NOT NULL,
    [RegistrationStatus]   INT        NOT NULL,
    [Cost]                 FLOAT (53) NOT NULL,
    [Charity]              INT        NOT NULL,
    [SponsorshipTaget]     NCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([RegistrationId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Registration_Envent]…';


GO
CREATE TABLE [dbo].[Registration_Envent] (
    [RegistrationEventId] INT        NOT NULL,
    [RegistrationId]      INT        NOT NULL,
    [EventId]             INT        NOT NULL,
    [BibNumber]           INT        NOT NULL,
    [RaceTime]            FLOAT (53) NOT NULL,
    PRIMARY KEY CLUSTERED ([RegistrationEventId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[RegistrationStatus]…';


GO
CREATE TABLE [dbo].[RegistrationStatus] (
    [RegistrationStatusId] INT          NOT NULL,
    [RegistrationStatus]   VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([RegistrationStatusId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Role]…';


GO
CREATE TABLE [dbo].[Role] (
    [RoleId]   INT          NOT NULL,
    [RoleName] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Runner]…';


GO
CREATE TABLE [dbo].[Runner] (
    [RunnerId]    INT          NOT NULL,
    [Email]       VARCHAR (50) NOT NULL,
    [Gender]      INT          NOT NULL,
    [DateOfBirth] NCHAR (10)   NULL,
    [CountryCode] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([RunnerId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Sponsorship]…';


GO
CREATE TABLE [dbo].[Sponsorship] (
    [SponsorshipId]  INT          NOT NULL,
    [SponsorName]    VARCHAR (50) NOT NULL,
    [RegistrationId] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([SponsorshipId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Staff]…';


GO
CREATE TABLE [dbo].[Staff] (
    [StaffId]     INT          NOT NULL,
    [FirstName]   VARCHAR (20) NOT NULL,
    [LastName]    VARCHAR (20) NOT NULL,
    [DateOfBirth] DATE         NOT NULL,
    [Gender]      CHAR (10)    NOT NULL,
    [PositionId]  INT          NOT NULL,
    [Email]       NCHAR (10)   NOT NULL,
    [Comments]    VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([StaffId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Timesheet]…';


GO
CREATE TABLE [dbo].[Timesheet] (
    [TimesheetId]   INT        NOT NULL,
    [StaffId]       INT        NOT NULL,
    [StartDateTime] DATETIME   NOT NULL,
    [EndDateTime]   DATETIME   NOT NULL,
    [PayAmount]     NCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([TimesheetId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[User]…';


GO
CREATE TABLE [dbo].[User] (
    [Email]     VARCHAR (50) NOT NULL,
    [Password]  VARCHAR (50) NOT NULL,
    [FirstName] NCHAR (10)   NOT NULL,
    [LastName]  NCHAR (10)   NOT NULL,
    [RoleId]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Email] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Volonteer]…';


GO
CREATE TABLE [dbo].[Volonteer] (
    [VolonteerId] INT          NOT NULL,
    [FirstName]   VARCHAR (50) NOT NULL,
    [LastName]    VARCHAR (50) NOT NULL,
    [CountryCode] INT          NOT NULL,
    [Gender]      INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([VolonteerId] ASC)
);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Event]…';


GO
ALTER TABLE [dbo].[Event]
    ADD FOREIGN KEY ([EventTypeId]) REFERENCES [dbo].[EventType] ([EventTypeId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Event]…';


GO
ALTER TABLE [dbo].[Event]
    ADD FOREIGN KEY ([MarathonId]) REFERENCES [dbo].[Marathon] ([MarathonId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Marathon]…';


GO
ALTER TABLE [dbo].[Marathon]
    ADD FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation]
    ADD FOREIGN KEY ([RannerId]) REFERENCES [dbo].[Runner] ([RunnerId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation]
    ADD FOREIGN KEY ([RaceKitOption]) REFERENCES [dbo].[RaceKitOption] ([RaceKitOptionId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation]
    ADD FOREIGN KEY ([RegistrationStatus]) REFERENCES [dbo].[RegistrationStatus] ([RegistrationStatusId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation]
    ADD FOREIGN KEY ([Charity]) REFERENCES [dbo].[Charity] ([CharityId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration_Envent]…';


GO
ALTER TABLE [dbo].[Registration_Envent]
    ADD FOREIGN KEY ([RegistrationId]) REFERENCES [dbo].[Regisrtation] ([RegistrationId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration_Envent]…';


GO
ALTER TABLE [dbo].[Registration_Envent]
    ADD FOREIGN KEY ([EventId]) REFERENCES [dbo].[Event] ([EventId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Runner]…';


GO
ALTER TABLE [dbo].[Runner]
    ADD FOREIGN KEY ([Email]) REFERENCES [dbo].[User] ([Email]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Runner]…';


GO
ALTER TABLE [dbo].[Runner]
    ADD FOREIGN KEY ([Gender]) REFERENCES [dbo].[Gender] ([GenderId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Runner]…';


GO
ALTER TABLE [dbo].[Runner]
    ADD FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Sponsorship]…';


GO
ALTER TABLE [dbo].[Sponsorship]
    ADD FOREIGN KEY ([RegistrationId]) REFERENCES [dbo].[Regisrtation] ([RegistrationId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Staff]…';


GO
ALTER TABLE [dbo].[Staff]
    ADD FOREIGN KEY ([PositionId]) REFERENCES [dbo].[Position] ([PositionId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Timesheet]…';


GO
ALTER TABLE [dbo].[Timesheet]
    ADD FOREIGN KEY ([StaffId]) REFERENCES [dbo].[Staff] ([StaffId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[User]…';


GO
ALTER TABLE [dbo].[User]
    ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Volonteer]…';


GO
ALTER TABLE [dbo].[Volonteer]
    ADD FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Volonteer]…';


GO
ALTER TABLE [dbo].[Volonteer]
    ADD FOREIGN KEY ([Gender]) REFERENCES [dbo].[Gender] ([GenderId]);


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ac2101ff-175b-4c51-b4d7-04549dfb8ba5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ac2101ff-175b-4c51-b4d7-04549dfb8ba5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e4743b04-dd59-46a3-978c-b7427da88d01')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e4743b04-dd59-46a3-978c-b7427da88d01')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ebbddfbc-5d7b-4b49-b3e5-8ee167fa329b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ebbddfbc-5d7b-4b49-b3e5-8ee167fa329b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8393ee88-3285-4bdc-a5c6-fe48c98b3160')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8393ee88-3285-4bdc-a5c6-fe48c98b3160')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd275ddfe-b8a1-4a8e-83b8-3bd1928b3b3e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d275ddfe-b8a1-4a8e-83b8-3bd1928b3b3e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '35f8d481-f835-4761-b0d2-f133f8e1c51c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('35f8d481-f835-4761-b0d2-f133f8e1c51c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4701264c-8ea4-4771-8e10-61a0b4b9e56a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4701264c-8ea4-4771-8e10-61a0b4b9e56a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f1a13ba6-1e92-41f5-b3ab-cffc9496cc74')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f1a13ba6-1e92-41f5-b3ab-cffc9496cc74')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ed621da1-c305-43a8-8e31-fa7177ab3e3e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ed621da1-c305-43a8-8e31-fa7177ab3e3e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '26c372fa-834d-473f-b69f-75de914723fa')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('26c372fa-834d-473f-b69f-75de914723fa')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '034a2b75-db90-4d50-ac85-1c3c832fbf34')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('034a2b75-db90-4d50-ac85-1c3c832fbf34')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fb95ae0f-1b4e-4d5d-a8bf-51dfda91c2fe')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fb95ae0f-1b4e-4d5d-a8bf-51dfda91c2fe')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ef76d611-b50f-4fdc-bb29-cf5095ee9baf')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ef76d611-b50f-4fdc-bb29-cf5095ee9baf')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bb2944dd-e28f-41f7-9432-3b3e400797ad')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bb2944dd-e28f-41f7-9432-3b3e400797ad')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '87b28efb-6c64-48b7-8596-a2529c0b5d8c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('87b28efb-6c64-48b7-8596-a2529c0b5d8c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '06e04626-2903-4579-9559-8b9eaa99f1a4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('06e04626-2903-4579-9559-8b9eaa99f1a4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '57f73734-2d62-45b9-96f2-7d52a44f5799')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('57f73734-2d62-45b9-96f2-7d52a44f5799')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f210b181-1bfe-4ca2-bfd8-9b309104517a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f210b181-1bfe-4ca2-bfd8-9b309104517a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '19e16fd5-6a02-4ab5-9491-52deeecd231b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('19e16fd5-6a02-4ab5-9491-52deeecd231b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '60788c9a-c80e-4927-a63c-0c17254c146a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('60788c9a-c80e-4927-a63c-0c17254c146a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd9d4d871-0849-414c-8615-83c25ff17a41')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d9d4d871-0849-414c-8615-83c25ff17a41')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Обновление завершено.';


GO
