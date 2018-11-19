USE [ToolsStore]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IM_VAT]
	@vat      bigint,
	@name     nvarchar(100),
	@rem      bit = null
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (@vat IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_VAT AS target
	USING (SELECT @vat, @name, @rem, getdate()) AS source (Vat, Name, Rem, DateLoad)
	ON (target.Vat = source.Vat)
	WHEN MATCHED THEN
		UPDATE SET Name       = source.Name,
				   Rem        = source.Rem,
				   DateLoad   = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Vat, Name, Rem, DateLoad)
		VALUES (source.Vat, source.Name, source.Rem, source.DateLoad);

END