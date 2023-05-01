CREATE PROCEDURE spDelete
(
	 @Id INT
	,@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'DELETE ' + @Tabela
			+ ' WHERE id = ' + CONVERT(VARCHAR(MAX), @Id)
	EXEC(@sql)
END
GO