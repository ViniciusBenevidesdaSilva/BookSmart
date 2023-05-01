-- Realiza a pesquisa de relacionamentos muitos para 1, 
-- a partir de uma chave estrangeira desejada
CREATE PROCEDURE spListagem_Foreign
(
	@Tabela VARCHAR(MAX)
	,@ForeignKeyName VARCHAR(MAX)
	,@Foreign_Id INT
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @Tabela
			+ ' WHERE ' + @ForeignKeyName + ' = ' + CAST(@Foreign_Id AS VARCHAR(MAX)) 
	EXEC(@sql)
END
GO