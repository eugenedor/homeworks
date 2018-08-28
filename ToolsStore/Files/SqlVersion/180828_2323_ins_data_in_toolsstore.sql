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
-- Изменить уровень локализации транзакции
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- Начать транзакцию
--
BEGIN TRANSACTION


--
-- Вставка данных в таблицу dbo.CT_BRAND
--
SET IDENTITY_INSERT dbo.CT_BRAND ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (0, N'', N'')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (1, N'Makita', N'Makita')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (2, N'DeWalt', N'DeWalt')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (3, N'Interskol', N'Интерскол')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (4, N'Bosch', N'Bosch')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (5, N'Bison', N'Зубр')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (6, N'Matrix', N'Matrix')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (7, N'Jonnesway', N'Jonnesway')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (8, N'Ombra', N'Ombra')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (9, N'Stayer', N'Stayer')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (10, N'Force', N'Force')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (11, N'Baikal', N'Байкал')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (12, N'Brigadier', N'Brigadier')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (13, N'Dexell', N'Dexell')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (14, N'Fiolent', N'Фиолент')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (15, N'Dexter', N'Dexter')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (16, N'Hitachi', N'Hitachi')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (17, N'Metabo', N'Metabo')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (18, N'Black&Decker', N'Black&Decker')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (19, N'Dremel', N'Dremel')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (20, N'КВТ', N'КВТ')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (21, N'Fit', N'Fit')
INSERT dbo.CT_BRAND(BrandId, Code, Name) VALUES (22, N'Enkor', N'Энкор')
GO
SET IDENTITY_INSERT dbo.CT_BRAND OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- Задать Identity значение для dbo.CT_BRAND
--
DBCC CHECKIDENT('dbo.CT_BRAND', RESEED, 22)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- Вставка данных в таблицу dbo.CT_CATEGORY
--
SET IDENTITY_INSERT dbo.CT_CATEGORY ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (1, N'ElectricTool', N'Электроинструменты', 1, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (2, N'AccElectricTool', N'Аксессуары для электроинструмента', 2, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (3, N'HandTool', N'Ручной инструмент', 3, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (4, N'FixingTool', N'Фиксирующий инструмент ', 4, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (5, N'ConstructionTool', N'Инструмент для строительства', 5, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (6, N'MeasuringTool', N'Измерительно-разметочный инструмент', 6, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (7, N'HouseholdTool', N'Хозяйственный инструмент', 7, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (8, N'Wrench', N'Гаечные ключи', 8, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (9, N'Hammer', N'Молотки', 9, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (10, N'Screw-driver', N'Отвертки', 10, '2018-07-31 10:49:29.720')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (11, N'Saw', N'Пилы', 11, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (12, N'Workplace', N'Всё для рабочего места', 12, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (13, N'MiniWash', N'Минимойки', 13, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (14, N'VacuumCleaner', N'Пылесосы', 14, '2018-07-31 10:49:29.723')
INSERT dbo.CT_CATEGORY(CategoryId, Code, Name, Ord, DateLoad) VALUES (15, N'Quillwort', N'Расходники', 15, '2018-07-31 10:49:29.723')
GO
SET IDENTITY_INSERT dbo.CT_CATEGORY OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- Задать Identity значение для dbo.CT_CATEGORY
--
DBCC CHECKIDENT('dbo.CT_CATEGORY', RESEED, 16)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- Вставка данных в таблицу dbo.CT_VAT
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
-- Задать Identity значение для dbo.CT_VAT
--
DBCC CHECKIDENT('dbo.CT_VAT', RESEED, 4)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- Вставка данных в таблицу dbo.MT_LOAD_RULE
--
SET IDENTITY_INSERT dbo.MT_LOAD_RULE ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.MT_LOAD_RULE(LoadRuleId, Code, FileName, IsActive, MethodLoad, PathToXsd, XsdName, Descr, Ord) VALUES (1, N'Category', N'Category.xml', 1, N'LoadCategory', N'xsd', N'Category.xsd', N'Категории', 1)
INSERT dbo.MT_LOAD_RULE(LoadRuleId, Code, FileName, IsActive, MethodLoad, PathToXsd, XsdName, Descr, Ord) VALUES (2, N'Vat', N'Vat.xml', 1, N'LoadVat', N'xsd', N'Vat.xsd', N'НДС', 2)
GO
SET IDENTITY_INSERT dbo.MT_LOAD_RULE OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- Задать Identity значение для dbo.MT_LOAD_RULE
--
DBCC CHECKIDENT('dbo.MT_LOAD_RULE', RESEED, 2)
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END


--
-- Вставка данных в таблицу dbo.SK_EQUIPMENT
--
SET IDENTITY_INSERT dbo.SK_EQUIPMENT ON
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (1, 1, N'Vibrgrinder', N'Вибрационная шлифовальная машина', N'Vibration grinder', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (2, 1, N'Screwdriver', N'Шуруповерт', N'Screwdriver', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (3, 1, N'Drill', N'Дрель', N'Drill', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (4, 1, N'Fretsaw', N'Лобзик', N'Fret saw', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (5, 1, N'Puncher', N'Перфоратор', N'Puncher', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (6, 1, N'Circularsaw', N'Циркулярная пила', N'Circular saw', 6)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (7, 1, N'Hairdryer', N'Фен', N'Hair dryer', 7)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (8, 1, N'Grinder', N'Углошлифовальная машина', N'Grinder', 8)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (9, 1, N'Millingcutter', N'Фрезер', N'Milling cutter', 9)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (10, 1, N'Electroplane', N'Электрорубанок', N'Electroplane', 10)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (11, 1, N'Engraver', N'Гравер', N'Engraver', 11)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (12, 2, N'Sawing', N'Пилка', N'Sawing', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (13, 2, N'Mill', N'Фреза', N'Mill', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (14, 2, N'Disk', N'Диск', N'Disk', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (15, 2, N'Sverlo', N'Сверло', N'Drill', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (16, 2, N'Boer', N'Бур', N'Boer', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (17, 3, N'Nippers', N'Кусачки', N'Nippers', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (18, 3, N'Pincers', N'Клещи', N'Pincers', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (19, 3, N'Combpliers', N'Пассатижи', N'Combination pliers', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (20, 3, N'Napilniks', N'Напильник', N'Files', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (21, 3, N'Scimetal', N'Ножницы по металлу', N'Scissors on metal', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (22, 3, N'Chisel', N'Стамеска', N'Chisel', 6)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (23, 3, N'Plane', N'Рубанок', N'Plane', 7)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (24, 4, N'Rivets', N'Заклепочник', N'Rivets', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (25, 4, N'Gluegun', N'Клеевой пистолет', N'Glue gun', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (26, 4, N'Stapler', N'Степлер', N'Stapler', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (27, 4, N'Clamp', N'Струбцина', N'Clamp', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (28, 5, N'Construction', N'Общестроительная работа', N'Construction work', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (29, 5, N'Painting', N'Малярная работа', N'Painting work', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (30, 5, N'Tiled', N'Плиточная работа', N'Tiled work', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (31, 5, N'Pipe', N'Трубная работа', N'Pipe work', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (32, 5, N'Gunssealant', N'Пистолеты для герметика', N'Guns for sealant', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (33, 5, N'Glasscutter', N'Стеклорез', N'Glass-cutter', 6)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (34, 6, N'Roulette', N'Рулетка', N'Roulette', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (35, 6, N'Level', N'Уровень', N'Level', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (36, 7, N'Knife', N'Нож строительный', N'Construction knives', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (37, 7, N'Pricker', N'Шило', N'Pricker', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (38, 8, N'Wrench', N'Гаечный ключ', N'Wrench', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (39, 8, N'Pipewrench', N'Трубный ключ', N'Pipe wrench', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (40, 8, N'Knob', N'Головка', N'Knob', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (41, 8, N'Graggers', N'Трещотка', N'Graggers', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (42, 8, N'Hexagon', N'Шестигранник', N'Hexagon', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (43, 9, N'Hammer', N'Молоток', N'Hammer', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (44, 9, N'Tooth', N'Зубило', N'Tooth', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (45, 9, N'Mallet', N'Киянка', N'Mallet', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (46, 9, N'Sledgehammer', N'Кувалда', N'Sledgehammer', 4)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (47, 9, N'Nailcatcher', N'Гвоздодёр', N'Nail-catcher', 5)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (48, 10, N'Dielscrew', N'Диэлектрическая отвертка', N'Dielectric screw-driver', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (49, 10, N'Crossscrew', N'Крестовая отвертка', N'Cross screw-driver', 2)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (50, 10, N'Shlitsscrew', N'Шлицевая отвертка', N'Shlitsevy screw-driver', 3)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (51, 11, N'Woodsaw', N'Пилы по дереву', N'Wood saw', 1)
INSERT dbo.SK_EQUIPMENT(EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (52, 11, N'Metalsaw', N'Пилы по металлу', N'Metal saw', 2)
GO
SET IDENTITY_INSERT dbo.SK_EQUIPMENT OFF
GO

IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END

--
-- Задать Identity значение для dbo.SK_EQUIPMENT
--
DBCC CHECKIDENT('dbo.SK_EQUIPMENT', RESEED, 52)
GO