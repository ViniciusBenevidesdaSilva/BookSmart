CREATE PROCEDURE spUpdate_Sexos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN
	
	UPDATE Sexos SET
		Descricao = @Descricao
	WHERE Id = @Id

END
GO