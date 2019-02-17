USE ToolsStore
GO

CREATE TRIGGER dbo.TR_FOR_INS_UPD_MT_LOAD_RULE_SPEC ON dbo.MT_LOAD_RULE_SPEC FOR INSERT, UPDATE
AS
BEGIN TRAN
  DECLARE @error NVARCHAR(100);

  --check--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE ISNULL(LTRIM(RTRIM(i.FileName)), '') = ''))
  BEGIN
	SET @error = 'Не указано наименование файла.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END
  COMMIT TRAN

GO