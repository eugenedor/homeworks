USE ToolsStore;
GO

--
--user table--
--
SELECT o.name object_name, c.name column_name, c.max_length, c.precision, c.scale, c.is_nullable, t.name type_name
FROM sys.objects AS o  
     JOIN sys.columns AS c 
	   ON o.object_id = c.object_id    
     JOIN sys.types AS t 
	   ON c.user_type_id=t.user_type_id  
WHERE o.type = 'U'
      and lower(o.name) = 'mt_setting'; 

--
--view--
--
SELECT o.name object_name, c.name column_name, c.max_length, c.precision, c.scale, c.is_nullable, t.name type_name
FROM sys.objects AS o  
     JOIN sys.columns AS c 
	   ON o.object_id = c.object_id    
     JOIN sys.types AS t 
	   ON c.user_type_id=t.user_type_id  
WHERE o.type = 'V'
      and lower(o.name) = 'v_order';

--
--stored procedure--
--
SELECT o.name AS object_name, o.type_desc, p.parameter_id, p.name AS parameter_name, t.name AS parameter_type, p.max_length, p.precision, p.scale, p.is_output
FROM sys.objects o 
     join sys.parameters p on o.object_id = p.object_id 
	 join sys.types t on p.user_type_id = t.user_type_id
WHERE o.type = 'P' 
      AND lower(o.name) = 'sp_get_load_rule'   
ORDER BY o.name;

--
--table function--
--
SELECT o.name AS object_name, o.type_desc, p.parameter_id, p.name AS parameter_name, TYPE_NAME(p.user_type_id) AS parameter_type, p.max_length, p.precision, p.scale, p.is_output  
FROM sys.objects o 
     join sys.parameters p on o.object_id = p.object_id 
	 join sys.types t on p.user_type_id = t.user_type_id
WHERE o.type = 'TF' 
      AND lower(o.name) = 'fn_get_numbers'   
ORDER BY o.name;

--
--scalar function--
--
SELECT o.name AS object_name, o.type_desc, p.parameter_id, p.name AS parameter_name, t.name AS parameter_type, p.max_length, p.precision, p.scale, p.is_output  
FROM sys.objects o 
     join sys.parameters p on o.object_id = p.object_id 
	 join sys.types t on p.user_type_id = t.user_type_id
WHERE o.type = 'FN' 
      AND lower(o.name) = 'fn_get_weekdays'   
ORDER BY o.name;