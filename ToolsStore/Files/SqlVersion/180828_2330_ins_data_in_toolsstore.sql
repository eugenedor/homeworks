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

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.SK_MODEL
--
SET IDENTITY_INSERT dbo.SK_MODEL ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (0, 0, 1000000000, N'')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (1, 1, 1000000001, N'BO3710')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (2, 3, 1000000002, N'���-104/220')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (3, 14, 1000000003, N'��� 4-28�')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (4, 1, 2000000004, N'DF031DWAE')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (5, 4, 2000000005, N'PSR1440LI-2')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (6, 5, 2000000006, N'��-18-2-�����1')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (7, 1, 3000000007, N'HP2050')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (8, 2, 3000000008, N'D21805KS')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (9, 16, 3000000009, N'DV13VSS')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (10, 16, 4000000010, N'CJ65V3')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (11, 1, 4000000011, N'4350T')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (12, 5, 4000000012, N'�-400-55')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (13, 1, 5000000013, N'HR2470')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (14, 3, 5000000014, N'�-18/450��')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (15, 4, 5000000015, N'Gbh 2-26 dre')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (16, 1, 6000000016, N'HS6601J')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (17, 5, 6000000017, N'���-900')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (18, 3, 6000000018, N'��-190/1600�')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (19, 3, 7000000019, N'��-2000�')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (20, 17, 7000000020, N'H16-500 601650500')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (21, 16, 7000000021, N'H 2000')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (22, 2, 8000000022, N'DWE 4051')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (23, 1, 8000000023, N'9558HN')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (24, 4, 8000000024, N'GWS7-115E')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (25, 4, 9000000025, N'POF 1400 ACE')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (26, 3, 9000000026, N'��-32/1900�')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (27, 14, 9000000027, N'��3-1100�')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (28, 11, 10000000028, N'�-312��')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (29, 2, 10000000029, N'DW 680')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (30, 18, 10000000030, N'KW 712KA')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (31, 19, 11000000031, N'4000 (1/45) F0134000JC')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (32, 5, 11000000032, N'��-130�� H172')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (33, 4, 11000000033, N'GRO')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (34, 13, 12000000034, N'T111C �')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (35, 4, 12000000035, N'SORT.�-����')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (36, 4, 13000000036, N'2608628408')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (37, 17, 14000000037, N'624307000')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (38, 4, 14000000038, N'2608600549')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (39, 1, 14000000039, N'P-52940')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (40, 6, 14000000040, N'74327')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (41, 4, 15000000041, N'HSS-R')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (42, 5, 15000000042, N'29615-H13')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (43, 6, 16000000043, N'SDS - Plus')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (44, 12, 17000000044, N'21087')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (45, 9, 17000000045, N'22027-5-18_Z01')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (46, 6, 17000000046, N'17524')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (47, 7, 17000000047, N'P107')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (48, 12, 17000000048, N'13820630')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (49, 20, 18000000049, N'WS-12/69476')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (50, 21, 18000000050, N'60033')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (51, 10, 18000000051, N'F-6805')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (52, 12, 19000000052, N'13820489')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (53, 15, 20000000053, N'18850329')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (54, 9, 21000000054, N'Master 23055-29')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (55, 12, 21000000055, N'Aviation Extrema 21237')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (56, 22, 22000000056, N'10401')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (57, 9, 23000000057, N'Standard 1865_z01')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (58, 9, 24000000058, N'MS180')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (59, 5, 25000000059, N'������ 06850-60-12_z02')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (60, 19, 25000000060, N'910-3')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (61, 12, 32000000061, N'13382896')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (62, 6, 34000000062, N'Magnetic')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (63, 6, 34000000063, N'Double fixation')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (64, 6, 35000000064, N'4-34583-120')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (65, 9, 38000000065, N'2-271256-H12')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (66, 5, 43000000066, N'20012-05')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (67, 22, 43000000067, N'1/6/36 23021')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (68, 21, 43000000068, N'44288')
INSERT dbo.SK_MODEL(ModelId, BrandId, Code, Name) VALUES (69, 5, 46000000069, N'������� (20111-5_z02)')
GO
SET IDENTITY_INSERT dbo.SK_MODEL OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.SK_MODEL
--
DBCC CHECKIDENT('dbo.SK_MODEL', RESEED, 69)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.RS_PRODUCT
--
SET IDENTITY_INSERT dbo.RS_PRODUCT ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (1, 1, 1, 1, NULL, N'Makita BO3710', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (2, 1, 3, 2, NULL, N'��������� ���-104/220', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (3, 1, 14, 3, NULL, N'������� ��� 4-28�', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (4, 2, 1, 4, NULL, N'Makita DF031DWAE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (5, 2, 4, 5, NULL, N'Bosch PSR1440LI-2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (6, 2, 5, 6, NULL, N'���� ��-18-2-�����1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (7, 3, 1, 7, NULL, N'Makita HP2050', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (8, 3, 2, 8, NULL, N'DeWalt D21805KS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (9, 3, 16, 9, NULL, N'Hitachi DV13VSS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (10, 4, 16, 10, NULL, N'Hitachi CJ65V3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (11, 4, 1, 11, NULL, N'Makita 4350T', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (12, 4, 5, 12, NULL, N'���� �-400-55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (13, 5, 1, 13, NULL, N'Makita HR2470', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (14, 5, 3, 14, NULL, N'��������� �-18/450��', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (15, 5, 4, 15, NULL, N'Bosch Gbh 2-26 dre', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (16, 6, 1, 16, NULL, N'Makita HS6601J', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (17, 6, 5, 17, NULL, N'���� ���-900', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (18, 6, 3, 18, NULL, N'��������� ��-190/1600�', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (19, 7, 3, 19, NULL, N'��������� ��-2000�', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (20, 7, 17, 20, NULL, N'Metabo H16-500 601650500', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (21, 7, 16, 21, NULL, N'Hitachi H 2000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (22, 8, 2, 22, NULL, N'DeWalt DWE 4051', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (23, 8, 1, 23, NULL, N'Makita 9558HN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (24, 8, 4, 24, NULL, N'Bosch GWS7-115E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (25, 9, 4, 25, NULL, N'Bosch POF 1400 ACE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (26, 9, 3, 26, NULL, N'��������� ��-32/1900�', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (27, 9, 14, 27, NULL, N'������� ��3-1100�', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (28, 10, 11, 28, NULL, N'������ �-312��', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (29, 10, 2, 29, NULL, N'DeWalt DW 680', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (30, 10, 18, 30, NULL, N'Black&Decker KW 712KA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (31, 11, 19, 31, NULL, N'Dremel 4000 (1/45) F0134000JC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (32, 11, 5, 32, NULL, N'���� ��-130�� H172', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (33, 11, 4, 33, NULL, N'Bosch GRO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (34, 12, 13, 34, NULL, N'Dexell T111C �', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (35, 12, 4, 35, NULL, N'Bosch SORT.�-����', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (36, 13, 4, 36, NULL, N'Bosch 2608628408', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (37, 14, 17, 37, NULL, N'Metabo 624307000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (38, 14, 4, 38, NULL, N'Bosch 2608600549', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (39, 14, 1, 39, NULL, N'Makita P-52940', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (40, 14, 6, 40, NULL, N'Matrix 74327', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (41, 15, 4, 41, NULL, N'Bosch HSS-R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (42, 15, 5, 42, NULL, N'���� 29615-H13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (43, 16, 6, 43, NULL, N'Matrix SDS - Plus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (44, 17, 12, 44, NULL, N'Brigadier 21087', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (45, 17, 9, 45, NULL, N'Stayer 22027-5-18_Z01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (46, 17, 6, 46, NULL, N'Matrix 17524', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (47, 17, 7, 47, NULL, N'Jonnesway P107', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (48, 17, 12, 48, NULL, N'Brigadier 13820630', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (49, 18, 20, 49, NULL, N'��� WS-12/69476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (50, 18, 21, 50, NULL, N'Fit 60033', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (51, 18, 10, 51, NULL, N'Force F-6805', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (52, 19, 12, 52, NULL, N'Brigadier 13820489', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (53, 20, 15, 53, NULL, N'Dexter 18850329', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (54, 21, 9, 54, NULL, N'Stayer Master 23055-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (55, 21, 12, 55, NULL, N'Brigadier Aviation Extrema 21237', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (56, 22, 22, 56, NULL, N'����� 10401', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (57, 23, 9, 57, NULL, N'Stayer Standard 1865_z01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (58, 24, 9, 58, NULL, N'Stayer MS180', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (59, 25, 5, 59, NULL, N'���� ������ 06850-60-12_z02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (60, 25, 19, 60, NULL, N'Dremel 910-3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (61, 32, 12, 61, NULL, N'Brigadier 13382896', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (62, 34, 6, 62, NULL, N'Matrix Magnetic', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (63, 34, 6, 63, NULL, N'Matrix Double fixation', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (64, 35, 6, 64, NULL, N'Matrix 4-34583-120', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (65, 38, 9, 65, NULL, N'Stayer 2-271256-H12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (66, 43, 5, 66, NULL, N'���� 20012-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (67, 43, 22, 67, NULL, N'����� 1/6/36 23021', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (68, 43, 21, 68, NULL, N'Fit 44288', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT dbo.RS_PRODUCT(ProductId, EquipmentId, BrandId, ModelId, ImageId, Name, Descr, Mass, Length, Width, Height, Color, Power, Kit) VALUES (69, 46, 5, 69, NULL, N'���� ������� (20111-5_z02)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT dbo.RS_PRODUCT OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.RS_PRODUCT
--
DBCC CHECKIDENT('dbo.RS_PRODUCT', RESEED, 70)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ������� ������ � ������� dbo.RS_PRICE
--
SET IDENTITY_INSERT dbo.RS_PRICE ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (1, 1, 3, 4190.00, 3550.85, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (2, 2, 3, 1648.00, 1396.61, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (3, 3, 3, 4804.00, 4071.19, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (4, 4, 3, 8990.00, 7618.64, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (5, 5, 3, 10179.00, 8626.27, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (6, 6, 3, 6590.00, 5584.75, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (7, 7, 3, 6962.00, 5900.00, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (8, 8, 3, 13590.00, 11516.95, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (9, 9, 3, 2294.00, 1944.07, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (10, 10, 3, 2675.00, 2266.95, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (11, 11, 3, 9888.00, 8379.66, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (12, 12, 3, 1500.00, 1271.19, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (13, 13, 3, 7990.00, 6771.19, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (14, 14, 3, 2890.00, 2449.15, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (15, 15, 3, 8990.00, 7618.64, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (16, 16, 3, 8990.00, 7618.64, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (17, 17, 3, 2960.00, 2508.47, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (18, 18, 3, 5299.00, 4490.68, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (19, 19, 3, 1686.00, 1428.81, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (20, 20, 3, 3999.00, 3388.98, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (21, 21, 3, 4716.00, 3996.61, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (22, 22, 3, 5099.00, 4321.19, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (23, 23, 3, 5390.00, 4567.80, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (24, 24, 3, 6300.00, 5338.98, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (25, 25, 3, 8149.00, 6905.93, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (26, 26, 3, 6400.00, 5423.73, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (27, 27, 3, 3509.00, 2973.73, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (28, 28, 3, 3000.00, 2542.37, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (29, 29, 3, 11090.00, 9398.31, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (30, 30, 3, 4059.00, 3439.83, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (31, 31, 3, 7790.00, 6601.69, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (32, 32, 3, 4260.00, 3610.17, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (33, 33, 3, 5806.00, 4920.34, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (34, 34, 3, 52.00, 44.07, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (35, 35, 3, 505.00, 427.97, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (36, 36, 3, 330.00, 279.66, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (37, 37, 3, 570.00, 483.05, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (38, 38, 3, 133.00, 112.71, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (39, 39, 3, 178.00, 150.85, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (40, 40, 3, 59.00, 50.00, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (41, 41, 3, 700.00, 593.22, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (42, 42, 3, 553.00, 468.64, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (43, 43, 3, 1188.00, 1006.78, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (44, 44, 3, 977.00, 827.97, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (45, 45, 3, 290.00, 245.76, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (46, 46, 3, 254.00, 215.25, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (47, 47, 3, 700.00, 593.22, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (48, 48, 3, 977.00, 827.97, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (49, 49, 3, 1545.00, 1309.32, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (50, 50, 3, 1109.00, 939.83, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (51, 51, 3, 1121.00, 950.00, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (52, 52, 3, 981.00, 831.36, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (53, 53, 3, 376.00, 318.64, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (54, 54, 3, 483.00, 409.32, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (55, 55, 3, 929.00, 787.29, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (56, 56, 3, 420.00, 355.93, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (57, 57, 3, 381.00, 322.88, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (58, 58, 3, 208.00, 176.27, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (59, 59, 3, 1073.00, 909.32, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (60, 60, 3, 1049.00, 888.98, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (61, 61, 3, 623.00, 527.97, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (62, 62, 3, 207.00, 175.42, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (63, 63, 3, 194.00, 164.41, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (64, 64, 3, 619.00, 524.58, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (65, 65, 3, 1491.00, 1263.56, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (66, 66, 3, 1031.00, 873.73, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (67, 67, 3, 447.00, 378.81, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (68, 68, 3, 788.00, 667.80, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
INSERT dbo.RS_PRICE(PriceId, ProductId, VatId, PriceWithVat, PriceWithoutVat, DateBegin, DateEnd) VALUES (69, 69, 3, 1616.00, 1369.49, '2018-01-01 00:00:00.000', '9999-12-31 00:00:00.000')
GO
SET IDENTITY_INSERT dbo.RS_PRICE OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- ������ Identity �������� ��� dbo.RS_PRICE
--
DBCC CHECKIDENT('dbo.RS_PRICE', RESEED, 69)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- ����������� ����������
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
SET NOEXEC OFF
GO