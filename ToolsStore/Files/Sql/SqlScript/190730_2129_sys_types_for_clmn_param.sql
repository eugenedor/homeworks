USE ToolsStore;
GO

--
--user table--
--
SELECT o.object_id, o.name object_name, c.name column_name, c.max_length, c.precision, c.scale, c.is_nullable, t.name type_name
FROM sys.objects AS o  
     JOIN sys.columns AS c 
	   ON o.object_id = c.object_id    
     JOIN sys.types AS t 
	   ON c.user_type_id=t.user_type_id  
WHERE o.type = 'U'
      and o.object_id = object_id('mt_setting');
      --and lower(o.name) = 'mt_setting'; 

--
--view--
--
SELECT o.object_id, o.name object_name, c.name column_name, c.max_length, c.precision, c.scale, c.is_nullable, t.name type_name
FROM sys.objects AS o  
     JOIN sys.columns AS c 
	   ON o.object_id = c.object_id    
     JOIN sys.types AS t 
	   ON c.user_type_id=t.user_type_id  
WHERE o.type = 'V'
      and o.object_id = object_id('v_order');
      --and lower(o.name) = 'v_order';

--
--stored procedure--
--
SELECT o.object_id, o.name AS object_name, o.type_desc, p.parameter_id, p.name AS parameter_name, t.name AS parameter_type, p.max_length, p.precision, p.scale, p.is_output
FROM sys.objects o 
     join sys.parameters p on o.object_id = p.object_id 
	 join sys.types t on p.user_type_id = t.user_type_id
WHERE o.type = 'P' 
      and o.object_id = object_id('sp_get_load_rule')
      --AND lower(o.name) = 'sp_get_load_rule'   
ORDER BY o.name;

--
--table function--
--
SELECT o.object_id, o.name AS object_name, o.type_desc, p.parameter_id, p.name AS parameter_name, TYPE_NAME(p.user_type_id) AS parameter_type, p.max_length, p.precision, p.scale, p.is_output  
FROM sys.objects o 
     join sys.parameters p on o.object_id = p.object_id 
	 join sys.types t on p.user_type_id = t.user_type_id
WHERE o.type = 'TF' 
      and o.object_id = object_id('fn_get_numbers')
      --AND lower(o.name) = 'fn_get_numbers'   
ORDER BY o.name;

--
--scalar function--
--
SELECT o.object_id, o.name AS object_name, o.type_desc, p.parameter_id, p.name AS parameter_name, t.name AS parameter_type, p.max_length, p.precision, p.scale, p.is_output  
FROM sys.objects o 
     join sys.parameters p on o.object_id = p.object_id 
	 join sys.types t on p.user_type_id = t.user_type_id
WHERE o.type = 'FN' 
      and o.object_id = object_id('fn_get_weekdays')
      --AND lower(o.name) = 'fn_get_weekdays'   
ORDER BY o.name;

--
--trigger--
--
SELECT o.object_id, o.name AS object_name, o.type_desc
FROM sys.objects o 
WHERE o.type = 'TR' 
      and o.object_id = object_id('tr_for_ins_upd_mt_load_rule_spec')
      AND lower(o.name) = 'TR_FOR_INS_UPD_MT_LOAD_RULE_SPEC'   
ORDER BY o.name;