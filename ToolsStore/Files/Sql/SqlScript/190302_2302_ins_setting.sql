USE ToolsStore;
GO

DELETE FROM dbo.MT_SETTING;
GO

--
-- Задать Identity значение для dbo.MT_SETTING
--
DBCC CHECKIDENT('dbo.MT_SETTING', RESEED, 0) WITH NO_INFOMSGS
GO

--
-- Вставка данных в таблицу dbo.MT_SETTING
--
SET IDENTITY_INSERT dbo.MT_SETTING ON
GO

INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (1, 'nameapp', 'Мастер-фломастер', 'Наименование продукта', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (2, 'version', '1.0', 'Версия продукта', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (3, 'datevers', '2019.03.01', 'Дата продукта', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (4, 'developer0', 'Дорохин Е. В.', 'Разработчик', 1)

INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (5, 'filepath', 'E:\FilesLoad', 'Исходная папка - директория для дальнейшей загрузки файлов', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (6, 'archivepath', 'E:\FilesLoad\FilesArchive', 'Архив - директория для успешной загрузки', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (7, 'trashpath', 'E:\FilesLoad\FilesTrash', 'Мусорка - директория для ошибочной загрузки', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (8, 'signgradation', 'true', 'Признак градации директорий (поддиректории)', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (9, 'culturename', 'en-US', 'Культура языка названия директории для градации папок', 1)

GO

SET IDENTITY_INSERT dbo.MT_SETTING OFF
GO

--
-- Задать Identity значение для dbo.MT_SETTING
--
DBCC CHECKIDENT('dbo.MT_SETTING', RESEED, 10) WITH NO_INFOMSGS
GO