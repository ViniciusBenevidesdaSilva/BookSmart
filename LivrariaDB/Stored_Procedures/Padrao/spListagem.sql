﻿CREATE PROCEDURE spListagem
(
	@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @Tabela
	EXEC(@sql)
END
GO