USE ToolsStore
GO

CREATE TRIGGER [dbo].[TR_FOR_INS_UPD_RS_PRODUCT] ON dbo.RS_PRODUCT FOR INSERT, UPDATE
AS
BEGIN TRAN
  IF NOT EXISTS (SELECT *
                 FROM INSERTED i
			          JOIN SK_MODEL m
				        ON i.ModelId = m.ModelId
					      AND i.BrandId = m.BrandId)
  BEGIN
    RAISERROR('Discrepancy of model and brand', 16, 1)
	ROLLBACK TRAN
  END
COMMIT TRAN