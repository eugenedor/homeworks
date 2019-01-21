USE ToolsStore;
GO

SELECT 
    st.name   [Table],
    sc.name   [Column],
    sep.value [Description]
FROM sys.tables st
     JOIN sys.columns sc ON st.object_id = sc.object_id
     LEFT JOIN sys.extended_properties sep ON st.object_id = sep.major_id
                                               AND sc.column_id = sep.minor_id
                                               AND sep.name = 'MS_Description'
where st.name = 'CT_CATEGORY'; --@TableName
      --AND sc.name = ''       --@ColumnName