-- Realiza a pesquisa de livros ordenando por genero e nota (avaliação)
CREATE PROCEDURE spListagem_Livros
(
	@Genero_Id INT
)
AS

BEGIN

	SELECT 
		l.*
		,AVG(ISNULL(a.Nota,0)) AS [Nota]
    FROM 
		Livros l
    LEFT JOIN 
		Avaliacoes a ON l.Id = a.Livro_Id

	GROUP BY 
		l.[Id]
		,l.[Genero_Id]
		,l.[Nome]
		,l.[Sinopse]
		,l.[Autor]
		,l.[Editora]
		,l.[Preco]
		,l.[Ano_publicacao]
    ORDER BY 
		CASE 
			WHEN l.Genero_Id = @Genero_Id THEN 0 
			ELSE 1 END, 
		AVG(ISNULL(a.Nota,0))
		DESC

END
GO