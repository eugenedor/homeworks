USE ToolsStore;
GO

PRINT '<<< INSERT CT_VAT >>>'
GO
SET IDENTITY_INSERT dbo.CT_VAT ON;
INSERT INTO dbo.CT_VAT (VatId, Vat, Name, Rem) VALUES (1,  0,  '0%',  0);
INSERT INTO dbo.CT_VAT (VatId, Vat, Name, Rem) VALUES (2,  10, '10%', 0);
INSERT INTO dbo.CT_VAT (VatId, Vat, Name, Rem) VALUES (3,  18, '18%', 0);
SET IDENTITY_INSERT dbo.CT_VAT OFF;
PRINT ''
GO


PRINT '<<< INSERT CT_CATEGORY >>>'
GO
SET IDENTITY_INSERT dbo.CT_CATEGORY ON;
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (1,  'ElectricTool',     '������������������',                  1);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (2,  'AccElectricTool',  '���������� ��� ������������������',   2);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (3,  'HandTool',         '������ ����������',                   3);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (4,  'FixingTool',       '����������� ����������',              4);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (5,  'ConstructionTool', '���������� ��� �������������',        5);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (6,  'MeasuringTool',    '������������-����������� ����������', 6);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (7,  'HouseholdTool',    '������������� ����������',            7);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (8,  'Wrench',           '������� �����',                       8); 
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (9,  'Hammer',           '�������',                             9);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (10, 'Screw-driver',     '��������',                            10);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (11, 'Saw',              '����',                                11);
SET IDENTITY_INSERT dbo.CT_CATEGORY OFF;
PRINT ''
GO

PRINT '<<< INSERT CT_BRAND >>>'
GO
SET IDENTITY_INSERT dbo.CT_BRAND ON;
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (0,  '',          '');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (1,  'Makita',    'Makita');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (2,  'DeWalt',    'DeWalt');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (3,  'Interskol', '���������')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (4,  'Bosch',     'Bosch')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (5,  'Bison',     '����')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (6,  'Matrix',    'Matrix');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (7,  'Jonnesway', 'Jonnesway');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (8,  'Ombra',     'Ombra')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (9,  'Stayer',    'Stayer')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (10, 'Force',     'Force')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (11, 'Baikal',    '������')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (12, 'Brigadier', 'Brigadier')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (13, 'Dexell',    'Dexell')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (14, 'Fiolent',   '�������')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (15, 'Dexter',    'Dexter')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (16, 'Hitachi',   'Hitachi')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (17, 'Metabo',    'Metabo')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (18, 'Black&Decker', 'Black&Decker')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (19, 'Dremel', 'Dremel')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (20, '���', '���')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (21, 'Fit', 'Fit')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (22, 'Enkor', '�����')
SET IDENTITY_INSERT dbo.CT_BRAND OFF;
PRINT ''
GO