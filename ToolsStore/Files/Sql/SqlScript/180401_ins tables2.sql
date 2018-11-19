USE ToolsStore;
GO

PRINT '<<< INSERT SK_EQUIPMENT >>>'
GO
SET IDENTITY_INSERT dbo.SK_EQUIPMENT ON;

--
--ElectricTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (1,  1, 'Vibrgrinder',   'Вибрационная шлифовальная машина', 'Vibration grinder', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (2,  1, 'Screwdriver',   'Шуруповерт',                       'Screwdriver',       2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (3,  1, 'Drill',         'Дрель',                            'Drill',             3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (4,  1, 'Fretsaw',       'Лобзик',                           'Fret saw',          4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (5,  1, 'Puncher',       'Перфоратор',                       'Puncher',           5);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (6,  1, 'Circularsaw',   'Циркулярная пила',                 'Circular saw',      6);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (7,  1, 'Hairdryer',     'Фен',                              'Hair dryer',        7);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (8,  1, 'Grinder',       'Углошлифовальная машина',          'Grinder',           8);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (9,  1, 'Millingcutter', 'Фрезер',                           'Milling cutter',    9);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (10, 1, 'Electroplane',  'Электрорубанок',                   'Electroplane',      10);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (11, 1, 'Engraver',      'Гравер',                           'Engraver',          11);

--
--AccElectricTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (12, 2, 'Sawing', 'Пилка',  'Sawing', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (13, 2, 'Mill',   'Фреза',  'Mill',   2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (14, 2, 'Disk',   'Диск',   'Disk',   3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (15, 2, 'Sverlo', 'Сверло', 'Drill',  4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (16, 2, 'Boer',   'Бур',    'Boer',   5);

--
--HandTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (17, 3, 'Nippers',    'Кусачки',            'Nippers',            1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (18, 3, 'Pincers',    'Клещи',              'Pincers',            2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (19, 3, 'Combpliers', 'Пассатижи',          'Combination pliers', 3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (20, 3, 'Napilniks',  'Напильник',          'Files',              4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (21, 3, 'Scimetal',   'Ножницы по металлу', 'Scissors on metal',  5);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (22, 3, 'Chisel',     'Стамеска',           'Chisel',             6);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (23, 3, 'Plane',      'Рубанок',            'Plane',              7);

--
--FixingTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (24, 4, 'Rivets',  'Заклепочник',      'Rivets',   1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (25, 4, 'Gluegun', 'Клеевой пистолет', 'Glue gun', 2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (26, 4, 'Stapler', 'Степлер',          'Stapler',  3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (27, 4, 'Clamp',   'Струбцина',        'Clamp',    4);

--
--ConstructionTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (28, 5, 'Construction', 'Общестроительная работа', 'Construction work', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (29, 5, 'Painting',     'Малярная работа',         'Painting work',     2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (30, 5, 'Tiled',        'Плиточная работа',        'Tiled work',        3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (31, 5, 'Pipe',         'Трубная работа',          'Pipe work',         4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (32, 5, 'Gunssealant',  'Пистолеты для герметика', 'Guns for sealant',  5);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (33, 5, 'Glasscutter',  'Стеклорез',               'Glass-cutter',      6);

--
--MeasuringTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (34, 6, 'Roulette', 'Рулетка', 'Roulette', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (35, 6, 'Level',    'Уровень', 'Level',    2);

--
--HouseholdTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (36, 7, 'Knife',   'Нож строительный', 'Construction knives', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (37, 7, 'Pricker', 'Шило',             'Pricker',             2);

--
--Wrench--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (38, 8, 'Wrench',     'Гаечный ключ', 'Wrench',      1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (39, 8, 'Pipewrench', 'Трубный ключ', 'Pipe wrench', 2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (40, 8, 'Knob',       'Головка',      'Knob',        3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (41, 8, 'Graggers',   'Трещотка',     'Graggers',    4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (42, 8, 'Hexagon',    'Шестигранник', 'Hexagon',     5);

--
--Hammer--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (43, 9, 'Hammer',       'Молоток',   'Hammer',       1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (44, 9, 'Tooth',        'Зубило',    'Tooth',        2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (45, 9, 'Mallet',       'Киянка',    'Mallet',       3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (46, 9, 'Sledgehammer', 'Кувалда',   'Sledgehammer', 4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (47, 9, 'Nailcatcher',  'Гвоздодёр', 'Nail-catcher', 5);

--
--Screw-driver--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (48, 10, 'Dielscrew',   'Диэлектрическая отвертка', 'Dielectric screw-driver', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (49, 10, 'Crossscrew',  'Крестовая отвертка',       'Cross screw-driver',      2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (50, 10, 'Shlitsscrew', 'Шлицевая отвертка',        'Shlitsevy screw-driver',  3);

--
--Saw--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (51, 11, 'Woodsaw',  'Пилы по дереву',  'Wood saw',  1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (52, 11, 'Metalsaw', 'Пилы по металлу', 'Metal saw', 2);

SET IDENTITY_INSERT dbo.SK_EQUIPMENT OFF;
PRINT ''
GO

