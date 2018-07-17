USE ToolsStore;
GO

PRINT '<<< INSERT SK_EQUIPMENT >>>'
GO
SET IDENTITY_INSERT dbo.SK_EQUIPMENT ON;

--
--ElectricTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (1,  1, 'Vibrgrinder',   '������������ ������������ ������', 'Vibration grinder', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (2,  1, 'Screwdriver',   '����������',                       'Screwdriver',       2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (3,  1, 'Drill',         '�����',                            'Drill',             3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (4,  1, 'Fretsaw',       '������',                           'Fret saw',          4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (5,  1, 'Puncher',       '����������',                       'Puncher',           5);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (6,  1, 'Circularsaw',   '����������� ����',                 'Circular saw',      6);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (7,  1, 'Hairdryer',     '���',                              'Hair dryer',        7);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (8,  1, 'Grinder',       '���������������� ������',          'Grinder',           8);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (9,  1, 'Millingcutter', '������',                           'Milling cutter',    9);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (10, 1, 'Electroplane',  '��������������',                   'Electroplane',      10);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (11, 1, 'Engraver',      '������',                           'Engraver',          11);

--
--AccElectricTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (12, 2, 'Sawing', '�����',  'Sawing', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (13, 2, 'Mill',   '�����',  'Mill',   2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (14, 2, 'Disk',   '����',   'Disk',   3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (15, 2, 'Sverlo', '������', 'Drill',  4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (16, 2, 'Boer',   '���',    'Boer',   5);

--
--HandTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (17, 3, 'Nippers',    '�������',            'Nippers',            1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (18, 3, 'Pincers',    '�����',              'Pincers',            2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (19, 3, 'Combpliers', '���������',          'Combination pliers', 3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (20, 3, 'Napilniks',  '���������',          'Files',              4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (21, 3, 'Scimetal',   '������� �� �������', 'Scissors on metal',  5);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (22, 3, 'Chisel',     '��������',           'Chisel',             6);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (23, 3, 'Plane',      '�������',            'Plane',              7);

--
--FixingTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (24, 4, 'Rivets',  '�����������',      'Rivets',   1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (25, 4, 'Gluegun', '������� ��������', 'Glue gun', 2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (26, 4, 'Stapler', '�������',          'Stapler',  3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (27, 4, 'Clamp',   '���������',        'Clamp',    4);

--
--ConstructionTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (28, 5, 'Construction', '���������������� ������', 'Construction work', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (29, 5, 'Painting',     '�������� ������',         'Painting work',     2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (30, 5, 'Tiled',        '��������� ������',        'Tiled work',        3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (31, 5, 'Pipe',         '������� ������',          'Pipe work',         4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (32, 5, 'Gunssealant',  '��������� ��� ���������', 'Guns for sealant',  5);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (33, 5, 'Glasscutter',  '���������',               'Glass-cutter',      6);

--
--MeasuringTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (34, 6, 'Roulette', '�������', 'Roulette', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (35, 6, 'Level',    '�������', 'Level',    2);

--
--HouseholdTool--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (36, 7, 'Knife',   '��� ������������', 'Construction knives', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (37, 7, 'Pricker', '����',             'Pricker',             2);

--
--Wrench--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (38, 8, 'Wrench',     '������� ����', 'Wrench',      1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (39, 8, 'Pipewrench', '������� ����', 'Pipe wrench', 2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (40, 8, 'Knob',       '�������',      'Knob',        3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (41, 8, 'Graggers',   '��������',     'Graggers',    4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (42, 8, 'Hexagon',    '������������', 'Hexagon',     5);

--
--Hammer--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (43, 9, 'Hammer',       '�������',   'Hammer',       1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (44, 9, 'Tooth',        '������',    'Tooth',        2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (45, 9, 'Mallet',       '������',    'Mallet',       3);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (46, 9, 'Sledgehammer', '�������',   'Sledgehammer', 4);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (47, 9, 'Nailcatcher',  '��������', 'Nail-catcher', 5);

--
--Screw-driver--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (48, 10, 'Dielscrew',   '��������������� ��������', 'Dielectric screw-driver', 1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (49, 10, 'Crossscrew',  '��������� ��������',       'Cross screw-driver',      2);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (50, 10, 'Shlitsscrew', '�������� ��������',        'Shlitsevy screw-driver',  3);

--
--Saw--
--
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (51, 11, 'Woodsaw',  '���� �� ������',  'Wood saw',  1);
INSERT INTO dbo.SK_EQUIPMENT (EquipmentId, CategoryId, Code, Name, NameExtra, Ord) VALUES (52, 11, 'Metalsaw', '���� �� �������', 'Metal saw', 2);

SET IDENTITY_INSERT dbo.SK_EQUIPMENT OFF;
PRINT ''
GO

