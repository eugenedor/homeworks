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
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (1,  'ElectricTool',     'Электроинструменты',                  1);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (2,  'AccElectricTool',  'Аксессуары для электроинструмента',   2);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (3,  'HandTool',         'Ручной инструмент',                   3);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (4,  'FixingTool',       'Фиксирующий инструмент',              4);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (5,  'ConstructionTool', 'Инструмент для строительства',        5);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (6,  'MeasuringTool',    'Измерительно-разметочный инструмент', 6);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (7,  'HouseholdTool',    'Хозяйственный инструмент',            7);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (8,  'Wrench',           'Гаечные ключи',                       8); 
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (9,  'Hammer',           'Молотки',                             9);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (10, 'Screw-driver',     'Отвертки',                            10);
INSERT INTO dbo.CT_CATEGORY (CategoryId, Code, Name, Ord) VALUES (11, 'Saw',              'Пилы',                                11);
SET IDENTITY_INSERT dbo.CT_CATEGORY OFF;
PRINT ''
GO

PRINT '<<< INSERT CT_BRAND >>>'
GO
SET IDENTITY_INSERT dbo.CT_BRAND ON;
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (0,  '',          '');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (1,  'Makita',    'Makita');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (2,  'DeWalt',    'DeWalt');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (3,  'Interskol', 'Интерскол')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (4,  'Bosch',     'Bosch')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (5,  'Bison',     'Зубр')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (6,  'Matrix',    'Matrix');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (7,  'Jonnesway', 'Jonnesway');
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (8,  'Ombra',     'Ombra')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (9,  'Stayer',    'Stayer')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (10, 'Force',     'Force')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (11, 'Baikal',    'Байкал')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (12, 'Brigadier', 'Brigadier')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (13, 'Dexell',    'Dexell')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (14, 'Fiolent',   'Фиолент')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (15, 'Dexter',    'Dexter')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (16, 'Hitachi',   'Hitachi')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (17, 'Metabo',    'Metabo')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (18, 'Black&Decker', 'Black&Decker')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (19, 'Dremel', 'Dremel')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (20, 'КВТ', 'КВТ')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (21, 'Fit', 'Fit')
INSERT INTO dbo.CT_BRAND (BrandId, Code, Name) VALUES (22, 'Enkor', 'Энкор')
SET IDENTITY_INSERT dbo.CT_BRAND OFF;
PRINT ''
GO