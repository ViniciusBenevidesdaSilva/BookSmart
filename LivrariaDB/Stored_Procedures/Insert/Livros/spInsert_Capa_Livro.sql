CREATE PROCEDURE spInsert_Capa_Livro
(
	@Id INT
	,@Livro_Id	INT
	,@Capa_Livro VARBINARY(MAX)
)
AS
BEGIN
	INSERT INTO Capa_Livro(Livro_Id,Capa_Livro)
	VALUES (@Livro_Id,@Capa_Livro);
END
GO