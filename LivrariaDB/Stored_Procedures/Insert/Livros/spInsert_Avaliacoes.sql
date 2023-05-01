CREATE PROCEDURE spInsert_Avaliacoes
(
	@Id INT
	,@Cliente_Id INT
	,@Livro_Id INT
	,@Data_Avaliacao DATETIME
	,@Nota INT
	,@Resenha VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Avaliacoes(Cliente_Id,Livro_Id,Data_Avaliacao,Nota,Resenha)
	VALUES (@Cliente_Id,@Livro_Id,@Data_Avaliacao,@Nota,@Resenha);
END
GO