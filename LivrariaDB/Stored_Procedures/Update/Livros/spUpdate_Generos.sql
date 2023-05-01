CREATE PROCEDURE spUpdate_Generos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN

	UPDATE Generos SET
		Descricao = @Descricao
	WHERE Id = @Id

END
GO