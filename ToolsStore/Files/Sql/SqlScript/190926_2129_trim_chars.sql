USE ToolsStore
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('FN_TRIM_CHARS') AND type = N'FN')
BEGIN
	DROP FUNCTION dbo.FN_TRIM_CHARS
END
GO

CREATE FUNCTION FN_TRIM_CHARS 
(
   @string NVARCHAR(MAX)
) 

RETURNS NVARCHAR(MAX) 
AS
BEGIN

DECLARE @empty NVARCHAR(1) = '';
DECLARE @p94   NVARCHAR(1) = '^';
DECLARE @p38   NVARCHAR(1) = '&';
DECLARE @p42   NVARCHAR(1) = '*';
DECLARE @p40   NVARCHAR(1) = '(';
--DECLARE @p95   NVARCHAR(1) = '_';
DECLARE @p41   NVARCHAR(1) = ')';
DECLARE @p96   NVARCHAR(1) = '`';
DECLARE @p126  NVARCHAR(1) = '~';
DECLARE @p123  NVARCHAR(1) = '{';
DECLARE @p125  NVARCHAR(1) = '}';
--DECLARE @p32   NVARCHAR(1) = ' ';
DECLARE @p91   NVARCHAR(1) = '[';
DECLARE @p63   NVARCHAR(1) = '?';
DECLARE @p93   NVARCHAR(1) = ']';
DECLARE @p92   NVARCHAR(1) = '\';
DECLARE @p47  NVARCHAR(1) = '/';
DECLARE @p124  NVARCHAR(1) = '|';
DECLARE @p60   NVARCHAR(1) = '<';
DECLARE @p62   NVARCHAR(1) = '>';
DECLARE @p64   NVARCHAR(1) = '@';
--DECLARE @p45   NVARCHAR(1) = '-';
DECLARE @p43   NVARCHAR(1) = '+';
DECLARE @p44   NVARCHAR(1) = ',';
DECLARE @p46   NVARCHAR(1) = '.';

RETURN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
       @string, @p94,  @empty), 
	            @p38,  @empty), 
				@p42,  @empty), 
				@p40,  @empty), 
				@p41,  @empty), 
				@p96,  @empty), 
				@p126, @empty), 
				@p123, @empty), 
				@p125, @empty), 
				@p91,  @empty), 
				@p63,  @empty), 
				@p93,  @empty), 
				@p92,  @empty), 
				@p47,  @empty), 
				@p124, @empty), 
				@p60,  @empty), 
				@p62,  @empty), 
				@p64,  @empty), 
				@p43,  @empty), 
				@p44,  @empty), 
				@p46,  @empty);
END
GO