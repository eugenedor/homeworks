SET LANGUAGE 'Russian'
SET DATEFORMAT ymd
SET ARITHABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT, XACT_ABORT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS OFF
GO

USE ToolsStore2
GO

IF DB_NAME() <> N'ToolsStore2' SET NOEXEC ON
GO


--
-- �������� ������� ����������� ����������
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- ������ ����������
--
BEGIN TRANSACTION


--
-- ������� ������ � ������� dbo.CT_BRAND
--
SET IDENTITY_INSERT dbo.CT_BRAND ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (0, N'', N'')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (1, N'Makita', N'Makita')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (2, N'DeWalt', N'DeWalt')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (3, N'Interskol', N'���������')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (4, N'Bosch', N'Bosch')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (5, N'Bison', N'����')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (6, N'Matrix', N'Matrix')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (7, N'Jonnesway', N'Jonnesway')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (8, N'Ombra', N'Ombra')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (9, N'Stayer', N'Stayer')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (10, N'Force', N'Force')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (11, N'Baikal', N'������')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (12, N'Brigadier', N'Brigadier')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (13, N'Dexell', N'Dexell')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (14, N'Fiolent', N'�������')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (15, N'Dexter', N'Dexter')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (16, N'Hitachi', N'Hitachi')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (17, N'Metabo', N'Metabo')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (18, N'Black&Decker', N'Black&Decker')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (19, N'Dremel', N'Dremel')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (20, N'���', N'���')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (21, N'Fit', N'Fit')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (22, N'Enkor', N'�����')
GO
SET IDENTITY_INSERT dbo.CT_BRAND OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.CT_BRAND
--
DBCC CHECKIDENT('dbo.CT_BRAND', RESEED, 22)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.CT_CATEGORY
--
SET IDENTITY_INSERT dbo.CT_CATEGORY ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (1, N'ElectricTool', N'������������������', 1, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (2, N'AccElectricTool', N'���������� ��� ������������������', 2, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (3, N'HandTool', N'������ ����������', 3, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (4, N'FixingTool', N'����������� ���������� ', 4, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (5, N'ConstructionTool', N'���������� ��� �������������', 5, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (6, N'MeasuringTool', N'������������-����������� ����������', 6, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (7, N'HouseholdTool', N'������������� ����������', 7, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (8, N'Wrench', N'������� �����', 8, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (9, N'Hammer', N'�������', 9, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (10, N'Screw-driver', N'��������', 10, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (11, N'Saw', N'����', 11, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (12, N'Workplace', N'�� ��� �������� �����', 12, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (13, N'MiniWash', N'���������', 13, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (14, N'VacuumCleaner', N'��������', 14, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (15, N'Quillwort', N'����������', 15, '2018-07-31 10:49:29.723')
GO
SET IDENTITY_INSERT dbo.CT_CATEGORY OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.CT_CATEGORY
--
DBCC CHECKIDENT('dbo.CT_CATEGORY', RESEED, 16)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.CT_VAT
--
SET IDENTITY_INSERT dbo.CT_VAT ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.CT_VAT(VatId, Vat, Name, Rem, DateLoad) VALUES (1, 0, N'0%', 0, '2018-07-31 10:49:29.740')
INSERT dbo.CT_VAT(VatId, Vat, Name, Rem, DateLoad) VALUES (2, 10, N'10%', 0, '2018-07-31 10:49:29.740')
INSERT dbo.CT_VAT(VatId, Vat, Name, Rem, DateLoad) VALUES (3, 18, N'18%', 0, '2018-07-31 10:49:29.740')
INSERT dbo.CT_VAT(VatId, Vat, Name, Rem, DateLoad) VALUES (4, 20, N'20%', 0, '2018-07-31 10:49:29.740')
GO
SET IDENTITY_INSERT dbo.CT_VAT OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.CT_VAT
--
DBCC CHECKIDENT('dbo.CT_VAT', RESEED, 4)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.MT_LOAD_RULE
--
SET IDENTITY_INSERT dbo.MT_LOAD_RULE ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.MT_LOAD_RULE(LoadRuleId, Code, FileName, IsActive, MethodLoad, PathToXsd, XsdName, Descr, Ord) VALUES (1, N'Category', N'Category.xml', 1, N'LoadCategory', N'xsd', N'Category.xsd', N'���������', 1)
INSERT dbo.MT_LOAD_RULE(LoadRuleId, Code, FileName, IsActive, MethodLoad, PathToXsd, XsdName, Descr, Ord) VALUES (2, N'Vat', N'Vat.xml', 1, N'LoadVat', N'xsd', N'Vat.xsd', N'���', 2)
GO
SET IDENTITY_INSERT dbo.MT_LOAD_RULE OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.MT_LOAD_RULE
--
DBCC CHECKIDENT('dbo.MT_LOAD_RULE', RESEED, 2)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.SK_EQUIPMENT
--
SET IDENTITY_INSERT dbo.SK_EQUIPMENT ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (1, 1, N'Vibrgrinder', N'������������ ������������ ������', N'Vibration grinder', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (2, 1, N'Screwdriver', N'����������', N'Screwdriver', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (3, 1, N'Drill', N'�����', N'Drill', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (4, 1, N'Fretsaw', N'������', N'Fret saw', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (5, 1, N'Puncher', N'����������', N'Puncher', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (6, 1, N'Circularsaw', N'����������� ����', N'Circular saw', 6)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (7, 1, N'Hairdryer', N'���', N'Hair dryer', 7)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (8, 1, N'Grinder', N'���������������� ������', N'Grinder', 8)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (9, 1, N'Millingcutter', N'������', N'Milling cutter', 9)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (10, 1, N'Electroplane', N'��������������', N'Electroplane', 10)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (11, 1, N'Engraver', N'������', N'Engraver', 11)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (12, 2, N'Sawing', N'�����', N'Sawing', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (13, 2, N'Mill', N'�����', N'Mill', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (14, 2, N'Disk', N'����', N'Disk', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (15, 2, N'Sverlo', N'������', N'Drill', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (16, 2, N'Boer', N'���', N'Boer', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (17, 3, N'Nippers', N'�������', N'Nippers', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (18, 3, N'Pincers', N'�����', N'Pincers', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (19, 3, N'Combpliers', N'���������', N'Combination pliers', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (20, 3, N'Napilniks', N'���������', N'Files', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (21, 3, N'Scimetal', N'������� �� �������', N'Scissors on metal', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (22, 3, N'Chisel', N'��������', N'Chisel', 6)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (23, 3, N'Plane', N'�������', N'Plane', 7)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (24, 4, N'Rivets', N'�����������', N'Rivets', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (25, 4, N'Gluegun', N'������� ��������', N'Glue gun', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (26, 4, N'Stapler', N'�������', N'Stapler', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (27, 4, N'Clamp', N'���������', N'Clamp', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (28, 5, N'Construction', N'���������������� ������', N'Construction work', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (29, 5, N'Painting', N'�������� ������', N'Painting work', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (30, 5, N'Tiled', N'��������� ������', N'Tiled work', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (31, 5, N'Pipe', N'������� ������', N'Pipe work', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (32, 5, N'Gunssealant', N'��������� ��� ���������', N'Guns for sealant', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (33, 5, N'Glasscutter', N'���������', N'Glass-cutter', 6)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (34, 6, N'Roulette', N'�������', N'Roulette', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (35, 6, N'Level', N'�������', N'Level', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (36, 7, N'Knife', N'��� ������������', N'Construction knives', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (37, 7, N'Pricker', N'����', N'Pricker', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (38, 8, N'Wrench', N'������� ����', N'Wrench', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (39, 8, N'Pipewrench', N'������� ����', N'Pipe wrench', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (40, 8, N'Knob', N'�������', N'Knob', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (41, 8, N'Graggers', N'��������', N'Graggers', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (42, 8, N'Hexagon', N'������������', N'Hexagon', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (43, 9, N'Hammer', N'�������', N'Hammer', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (44, 9, N'Tooth', N'������', N'Tooth', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (45, 9, N'Mallet', N'������', N'Mallet', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (46, 9, N'Sledgehammer', N'�������', N'Sledgehammer', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (47, 9, N'Nailcatcher', N'��������', N'Nail-catcher', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (48, 10, N'Dielscrew', N'��������������� ��������', N'Dielectric screw-driver', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (49, 10, N'Crossscrew', N'��������� ��������', N'Cross screw-driver', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (50, 10, N'Shlitsscrew', N'�������� ��������', N'Shlitsevy screw-driver', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (51, 11, N'Woodsaw', N'���� �� ������', N'Wood saw', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (52, 11, N'Metalsaw', N'���� �� �������', N'Metal saw', 2)
GO
SET IDENTITY_INSERT dbo.SK_EQUIPMENT OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.SK_EQUIPMENT
--
DBCC CHECKIDENT('dbo.SK_EQUIPMENT', RESEED, 52)
GO