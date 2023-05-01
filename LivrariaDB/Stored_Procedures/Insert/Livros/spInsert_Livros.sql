CREATE PROCEDURE spInsert_Livros
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
	INSERT INTO Livros(Genero_Id,Nome,Sinopse,Autor,Editora,Preco,Ano_publicacao)
	VALUES (@Genero_Id,@Nome,@Sinopse,@Autor,@Editora,@Preco,@Ano_publicacao);
END
GO