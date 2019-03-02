USE ToolsStore;
GO

DELETE FROM dbo.MT_SETTING;
GO

--
-- ������ Identity �������� ��� dbo.MT_SETTING
--
DBCC CHECKIDENT('dbo.MT_SETTING', RESEED, 0) WITH NO_INFOMSGS
GO

--
-- ������� ������ � ������� dbo.MT_SETTING
--
SET IDENTITY_INSERT dbo.MT_SETTING ON
GO

INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (1, 'nameapp', '������-���������', '������������ ��������', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (2, 'version', '1.0', '������ ��������', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (3, 'datevers', '2019.03.01', '���� ��������', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (4, 'developer0', '������� �. �.', '�����������', 1)

INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (5, 'filepath', 'E:\FilesLoad', '�������� ����� - ���������� ��� ���������� �������� ������', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (6, 'archivepath', 'E:\FilesLoad\FilesArchive', '����� - ���������� ��� �������� ��������', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (7, 'trashpath', 'E:\FilesLoad\FilesTrash', '������� - ���������� ��� ��������� ��������', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (8, 'signgradation', 'true', '������� �������� ���������� (�������������)', 1)
INSERT dbo.MT_SETTING(SettingId, Code, Value, Descr, IsActive) VALUES (9, 'culturename', 'en-US', '�������� ����� �������� ���������� ��� �������� �����', 1)

GO

SET IDENTITY_INSERT dbo.MT_SETTING OFF
GO

--
-- ������ Identity �������� ��� dbo.MT_SETTING
--
DBCC CHECKIDENT('dbo.MT_SETTING', RESEED, 10) WITH NO_INFOMSGS
GO