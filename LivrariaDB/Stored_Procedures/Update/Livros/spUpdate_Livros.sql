CREATE PROCEDURE spUpdate_Livros
(
	@Id INT
	,@Genero_Id	INT
	,@Nome VARCHAR(MAX)
	,@Sinopse VARCHAR(MAX)
	,@Autor VARCHAR(MAX)
	,@Editora VARCHAR(MAX)
	,@Preco DECIMAL(10,2)
	,@Ano_publicacao INT
)
AS
BEGIN
	
	UPDATE Livros SET 
		Genero_Id= @Genero_Id
		,Nome = @Nome
		,Sinopse = @Sinopse
		,Autor = @Autor
		,Editora = @Editora
		,Preco = @Preco
		,Ano_publicacao = @Ano_publicacao
	WHERE Id = @Id

END
GO