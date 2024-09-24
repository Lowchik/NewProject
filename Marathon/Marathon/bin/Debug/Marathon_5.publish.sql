/*
Скрипт развертывания для DSA

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DSA"
:setvar DefaultFilePrefix "DSA"
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
USE [$(DatabaseName)];


GO
/*
Удаляется столбец [dbo].[Staff].[Post], возможна потеря данных.

Удаляется столбец [dbo].[Staff].[Staff_ID], возможна потеря данных.

Необходимо добавить столбец [dbo].[Staff].[Comments] таблицы [dbo].[Staff], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Staff].[DateOfBirth] таблицы [dbo].[Staff], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Staff].[Email] таблицы [dbo].[Staff], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Staff].[Gender] таблицы [dbo].[Staff], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Staff].[PositionId] таблицы [dbo].[Staff], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Staff].[StaffId] таблицы [dbo].[Staff], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Столбец FirstName таблицы [dbo].[Staff] необходимо изменить с NULL на NOT NULL. Если таблица содержит данные, скрипт ALTER может оказаться неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо добавить значения этого столбца во все строки, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Тип FirstName столбца в таблице [dbo].[Staff] в настоящее время  NCHAR (10) NULL, но изменяется на  VARCHAR (20) NOT NULL. Может произойти потеря данных, и развертывание может завершиться ошибкой, если столбец содержит данные, несовместимые с типом  VARCHAR (20) NOT NULL.

Столбец LastName таблицы [dbo].[Staff] необходимо изменить с NULL на NOT NULL. Если таблица содержит данные, скрипт ALTER может оказаться неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо добавить значения этого столбца во все строки, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Тип LastName столбца в таблице [dbo].[Staff] в настоящее время  NCHAR (10) NULL, но изменяется на  VARCHAR (20) NOT NULL. Может произойти потеря данных, и развертывание может завершиться ошибкой, если столбец содержит данные, несовместимые с типом  VARCHAR (20) NOT NULL.
*/

IF EXISTS (select top 1 1 from [dbo].[Staff])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Удаляется столбец [dbo].[User].[Staff_ID], возможна потеря данных.

Удаляется столбец [dbo].[User].[User_ID], возможна потеря данных.

Необходимо добавить столбец [dbo].[User].[FirstName] таблицы [dbo].[User], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[User].[LastName] таблицы [dbo].[User], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[User].[RoleId] таблицы [dbo].[User], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Столбец Email таблицы [dbo].[User] необходимо изменить с NULL на NOT NULL. Если таблица содержит данные, скрипт ALTER может оказаться неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо добавить значения этого столбца во все строки, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Тип Email столбца в таблице [dbo].[User] в настоящее время  NCHAR (10) NULL, но изменяется на  VARCHAR (50) NOT NULL. Может произойти потеря данных, и развертывание может завершиться ошибкой, если столбец содержит данные, несовместимые с типом  VARCHAR (50) NOT NULL.

Столбец Password таблицы [dbo].[User] необходимо изменить с NULL на NOT NULL. Если таблица содержит данные, скрипт ALTER может оказаться неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо добавить значения этого столбца во все строки, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Тип Password столбца в таблице [dbo].[User] в настоящее время  NCHAR (10) NULL, но изменяется на  VARCHAR (250) NOT NULL. Может произойти потеря данных, и развертывание может завершиться ошибкой, если столбец содержит данные, несовместимые с типом  VARCHAR (250) NOT NULL.
*/

IF EXISTS (select top 1 1 from [dbo].[User])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
PRINT N'Операция рефакторинга Rename с помощью ключа ac2101ff-175b-4c51-b4d7-04549dfb8ba5 пропущена, элемент [dbo].[Role].[Id] (SqlSimpleColumn) не будет переименован в RoleId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа e4743b04-dd59-46a3-978c-b7427da88d01 пропущена, элемент [dbo].[Urers].[Id] (SqlSimpleColumn) не будет переименован в Emai';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа ebbddfbc-5d7b-4b49-b3e5-8ee167fa329b пропущена, элемент [dbo].[Urers].[Email] (SqlSimpleColumn) не будет переименован в Password';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 8393ee88-3285-4bdc-a5c6-fe48c98b3160 пропущена, элемент [dbo].[Runner].[Id] (SqlSimpleColumn) не будет переименован в RunnerId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа d275ddfe-b8a1-4a8e-83b8-3bd1928b3b3e пропущена, элемент [dbo].[User].[Emai] (SqlSimpleColumn) не будет переименован в Email';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 35f8d481-f835-4761-b0d2-f133f8e1c51c пропущена, элемент [dbo].[Gender].[Id] (SqlSimpleColumn) не будет переименован в Gender';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 4701264c-8ea4-4771-8e10-61a0b4b9e56a пропущена, элемент [dbo].[Country].[Id] (SqlSimpleColumn) не будет переименован в CountryCode';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа f1a13ba6-1e92-41f5-b3ab-cffc9496cc74 пропущена, элемент [dbo].[Volonteer].[Id] (SqlSimpleColumn) не будет переименован в VolonteerId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа ed621da1-c305-43a8-8e31-fa7177ab3e3e пропущена, элемент [dbo].[Charity].[Id] (SqlSimpleColumn) не будет переименован в CharityId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 26c372fa-834d-473f-b69f-75de914723fa пропущена, элемент [dbo].[RegistrationStatus].[Id] (SqlSimpleColumn) не будет переименован в RegistrationStatusId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 034a2b75-db90-4d50-ac85-1c3c832fbf34 пропущена, элемент [dbo].[RaceKitOption].[Id] (SqlSimpleColumn) не будет переименован в RaceKitOptionId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа fb95ae0f-1b4e-4d5d-a8bf-51dfda91c2fe пропущена, элемент [dbo].[Marathon].[Id] (SqlSimpleColumn) не будет переименован в MarathonId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа ef76d611-b50f-4fdc-bb29-cf5095ee9baf пропущена, элемент [dbo].[EventType].[Id] (SqlSimpleColumn) не будет переименован в EventTypeId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа bb2944dd-e28f-41f7-9432-3b3e400797ad пропущена, элемент [dbo].[EventType].[EventTypeNAme] (SqlSimpleColumn) не будет переименован в EventTypeName';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 87b28efb-6c64-48b7-8596-a2529c0b5d8c пропущена, элемент [dbo].[Event].[Id] (SqlSimpleColumn) не будет переименован в EventId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 06e04626-2903-4579-9559-8b9eaa99f1a4 пропущена, элемент [dbo].[Registration_Envent].[Id] (SqlSimpleColumn) не будет переименован в RegistrationEventId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 57f73734-2d62-45b9-96f2-7d52a44f5799 пропущена, элемент [dbo].[RegisrtationId].[Id] (SqlSimpleColumn) не будет переименован в RegistrationId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа f210b181-1bfe-4ca2-bfd8-9b309104517a пропущена, элемент [dbo].[Sponsorship].[Id] (SqlSimpleColumn) не будет переименован в SponsorshipId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 19e16fd5-6a02-4ab5-9491-52deeecd231b пропущена, элемент [dbo].[Position].[Id] (SqlSimpleColumn) не будет переименован в PositionId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 60788c9a-c80e-4927-a63c-0c17254c146a пропущена, элемент [dbo].[Staff].[Id] (SqlSimpleColumn) не будет переименован в StaffId';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа d9d4d871-0849-414c-8615-83c25ff17a41 пропущена, элемент [dbo].[Timesheet].[Id] (SqlSimpleColumn) не будет переименован в TimesheetId';


GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[User]…';


GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK__User__Staff_ID__286302EC];


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[Staff]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Staff] (
    [StaffId]     INT          NOT NULL,
    [FirstName]   VARCHAR (20) NOT NULL,
    [LastName]    VARCHAR (20) NOT NULL,
    [DateOfBirth] DATE         NOT NULL,
    [Gender]      CHAR (10)    NOT NULL,
    [PositionId]  INT          NOT NULL,
    [Email]       VARCHAR (50) NOT NULL,
    [Comments]    VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([StaffId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Staff])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Staff] ([FirstName], [LastName])
        SELECT [FirstName],
               [LastName]
        FROM   [dbo].[Staff];
    END

DROP TABLE [dbo].[Staff];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Staff]', N'Staff';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[User]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_User] (
    [Email]     VARCHAR (50)  NOT NULL,
    [Password]  VARCHAR (250) NOT NULL,
    [FirstName] VARCHAR (50)  NOT NULL,
    [LastName]  VARCHAR (50)  NOT NULL,
    [RoleId]    INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Email] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[User])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_User] ([Email], [Password])
        SELECT   [Email],
                 [Password]
        FROM     [dbo].[User]
        ORDER BY [Email] ASC;
    END

DROP TABLE [dbo].[User];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_User]', N'User';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


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
    [GenderId] INT          NOT NULL,
    [Gender]   VARCHAR (50) NOT NULL,
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
    [YearHeld]     VARCHAR (50) NOT NULL,
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
    [RegistrationId]       INT          NOT NULL,
    [RannerId]             INT          NOT NULL,
    [RegistrationDateTime] DATETIME     NOT NULL,
    [RaceKitOption]        INT          NOT NULL,
    [RegistrationStatus]   INT          NOT NULL,
    [Cost]                 FLOAT (53)   NOT NULL,
    [Charity]              INT          NOT NULL,
    [SponsorshipTaget]     VARCHAR (50) NOT NULL,
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
    [DateOfBirth] DATE         NULL,
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
PRINT N'Идет создание Таблица [dbo].[Timesheet]…';


GO
CREATE TABLE [dbo].[Timesheet] (
    [TimesheetId]   INT          NOT NULL,
    [StaffId]       INT          NOT NULL,
    [StartDateTime] DATETIME     NOT NULL,
    [EndDateTime]   DATETIME     NOT NULL,
    [PayAmount]     VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([TimesheetId] ASC)
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
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[User]…';


GO
ALTER TABLE [dbo].[User] WITH NOCHECK
    ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Staff]…';


GO
ALTER TABLE [dbo].[Staff] WITH NOCHECK
    ADD FOREIGN KEY ([PositionId]) REFERENCES [dbo].[Position] ([PositionId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Event]…';


GO
ALTER TABLE [dbo].[Event] WITH NOCHECK
    ADD FOREIGN KEY ([EventTypeId]) REFERENCES [dbo].[EventType] ([EventTypeId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Event]…';


GO
ALTER TABLE [dbo].[Event] WITH NOCHECK
    ADD FOREIGN KEY ([MarathonId]) REFERENCES [dbo].[Marathon] ([MarathonId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Marathon]…';


GO
ALTER TABLE [dbo].[Marathon] WITH NOCHECK
    ADD FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation] WITH NOCHECK
    ADD FOREIGN KEY ([RannerId]) REFERENCES [dbo].[Runner] ([RunnerId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation] WITH NOCHECK
    ADD FOREIGN KEY ([RaceKitOption]) REFERENCES [dbo].[RaceKitOption] ([RaceKitOptionId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation] WITH NOCHECK
    ADD FOREIGN KEY ([RegistrationStatus]) REFERENCES [dbo].[RegistrationStatus] ([RegistrationStatusId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Regisrtation]…';


GO
ALTER TABLE [dbo].[Regisrtation] WITH NOCHECK
    ADD FOREIGN KEY ([Charity]) REFERENCES [dbo].[Charity] ([CharityId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration_Envent]…';


GO
ALTER TABLE [dbo].[Registration_Envent] WITH NOCHECK
    ADD FOREIGN KEY ([RegistrationId]) REFERENCES [dbo].[Regisrtation] ([RegistrationId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration_Envent]…';


GO
ALTER TABLE [dbo].[Registration_Envent] WITH NOCHECK
    ADD FOREIGN KEY ([EventId]) REFERENCES [dbo].[Event] ([EventId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Runner]…';


GO
ALTER TABLE [dbo].[Runner] WITH NOCHECK
    ADD FOREIGN KEY ([Email]) REFERENCES [dbo].[User] ([Email]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Runner]…';


GO
ALTER TABLE [dbo].[Runner] WITH NOCHECK
    ADD FOREIGN KEY ([Gender]) REFERENCES [dbo].[Gender] ([GenderId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Runner]…';


GO
ALTER TABLE [dbo].[Runner] WITH NOCHECK
    ADD FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Sponsorship]…';


GO
ALTER TABLE [dbo].[Sponsorship] WITH NOCHECK
    ADD FOREIGN KEY ([RegistrationId]) REFERENCES [dbo].[Regisrtation] ([RegistrationId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Timesheet]…';


GO
ALTER TABLE [dbo].[Timesheet] WITH NOCHECK
    ADD FOREIGN KEY ([StaffId]) REFERENCES [dbo].[Staff] ([StaffId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Volonteer]…';


GO
ALTER TABLE [dbo].[Volonteer] WITH NOCHECK
    ADD FOREIGN KEY ([CountryCode]) REFERENCES [dbo].[Country] ([CountryCode]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Volonteer]…';


GO
ALTER TABLE [dbo].[Volonteer] WITH NOCHECK
    ADD FOREIGN KEY ([Gender]) REFERENCES [dbo].[Gender] ([GenderId]);


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере
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
PRINT N'Существующие данные проверяются относительно вновь созданных ограничений';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.User'), OBJECT_ID(N'dbo.Staff'), OBJECT_ID(N'dbo.Event'), OBJECT_ID(N'dbo.Marathon'), OBJECT_ID(N'dbo.Regisrtation'), OBJECT_ID(N'dbo.Registration_Envent'), OBJECT_ID(N'dbo.Runner'), OBJECT_ID(N'dbo.Sponsorship'), OBJECT_ID(N'dbo.Timesheet'), OBJECT_ID(N'dbo.Volonteer'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Проверка ограничения: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Ошибка при проверке ограничения:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'Произошла ошибка при проверке ограничений', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Обновление завершено.';


GO
