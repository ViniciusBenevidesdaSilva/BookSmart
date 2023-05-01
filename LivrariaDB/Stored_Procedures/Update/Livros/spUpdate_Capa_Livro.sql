CREATE PROCEDURE spUpdate_Capa_Livro
(
	@Id INT
	,@Livro_Id	INT
	,@Capa_Livro VARBINARY(MAX)
)
AS
BEGIN
	
	UPDATE Capa_Livro SET 
		Livro_Id= @Livro_Id
		,Capa_Livro = @Capa_Livro
	WHERE Id = @Id

END
GO