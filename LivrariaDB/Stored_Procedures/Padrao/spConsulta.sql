CREATE PROCEDURE spConsulta
(
	 @Id INT
	,@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @Tabela 
			+ ' WHERE id = ' + CONVERT(VARCHAR(MAX), @Id)
	EXEC(@sql)
END
GO