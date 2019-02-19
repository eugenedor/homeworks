USE ToolsStore
GO

CREATE TRIGGER dbo.TR_FOR_INS_UPD_MT_LOAD_RULE_SPEC ON dbo.MT_LOAD_RULE_SPEC FOR INSERT, UPDATE
AS
BEGIN TRAN
  DECLARE @error NVARCHAR(100);

  --check data--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE NULLIF(i.Data, 0x00) IS NULL))
  BEGIN
	SET @error = 'Файл не выбран. Отсутствуют данные.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END  
  
  --check filename--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE ISNULL(LTRIM(RTRIM(i.FileName)), '') = ''))
  BEGIN
	SET @error = 'Не указано наименование файла.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END

  --check mimetype--
  IF (EXISTS(SELECT i.LoadRuleSpecId
			 FROM INSERTED i
			 WHERE ISNULL(LOWER(i.MimeType), '') NOT LIKE '%xml%'))
  BEGIN
	SET @error = 'Тип содержимого MIME файла не является xml.';
    RAISERROR(@error, 16, 1)
	ROLLBACK TRAN    
  END

  COMMIT TRAN
GO