USE ToolsStore
GO

ALTER PROCEDURE dbo.SP_GET_LOAD_RULE
	@Path NVARCHAR(1000)
AS
BEGIN
  SET @Path = ISNULL(LOWER(LTRIM(RTRIM(@Path))), '');

  SET @Path = 	   
        CASE LEN(@Path) 
	      WHEN 0 THEN @Path
          ELSE CASE 
			     WHEN SUBSTRING(@Path, LEN(@Path), 1) = '\' THEN LEFT(@Path, LEN(@Path)-1)
				 ELSE @Path
			   END			  			 			   
        END;

  SELECT lr.LoadRuleId, 
	     lr.Code, 
	     lr.Pattern, 
	     lr.Method,
	     lr.Descr,
	     lr.IsActive, 
	     lr.Ord,
	     lrs.LoadRuleSpecId, 
	     lrs.FileName, 
	     ISNULL(NULLIF(@Path, '') + '\', '') + lrs.PathToFile + '\' AS PathToFile,
	     lrs.IsMain   
  FROM dbo.MT_LOAD_RULE lr
	   JOIN dbo.MT_LOAD_RULE_SPEC lrs
	     ON lr.LoadRuleId = lrs.LoadRuleId
  ORDER BY CASE WHEN lr.IsActive = 1 THEN 1 ELSE 2 END, lr.Ord, 
           CASE WHEN lrs.IsMain = 1 THEN 1 ELSE 2 END;
END
