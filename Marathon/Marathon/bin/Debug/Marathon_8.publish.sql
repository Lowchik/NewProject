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
Тип RoleId столбца в таблице [dbo].[Role] в настоящее время  INT NOT NULL, но изменяется на  CHAR (1) NOT NULL. Может произойти потеря данных, и развертывание может завершиться ошибкой, если столбец содержит данные, несовместимые с типом  CHAR (1) NOT NULL.
*/

IF EXISTS (select top 1 1 from [dbo].[Role])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Тип RoleId столбца в таблице [dbo].[User] в настоящее время  INT NOT NULL, но изменяется на  CHAR (1) NOT NULL. Может произойти потеря данных, и развертывание может завершиться ошибкой, если столбец содержит данные, несовместимые с типом  CHAR (1) NOT NULL.
*/

IF EXISTS (select top 1 1 from [dbo].[User])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
PRINT N'Идет удаление Внешний ключ ограничение без названия для [dbo].[User]…';


GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK__User__RoleId__534D60F1];


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[Role]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Role] (
    [RoleId]   CHAR (1)     NOT NULL,
    [RoleName] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Role])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Role] ([RoleId], [RoleName])
        SELECT   [RoleId],
                 [RoleName]
        FROM     [dbo].[Role]
        ORDER BY [RoleId] ASC;
    END

DROP TABLE [dbo].[Role];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Role]', N'Role';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Идет изменение Таблица [dbo].[User]…';


GO
ALTER TABLE [dbo].[User] ALTER COLUMN [RoleId] CHAR (1) NOT NULL;


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[User]…';


GO
ALTER TABLE [dbo].[User] WITH NOCHECK
    ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]);


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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.User'))
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
