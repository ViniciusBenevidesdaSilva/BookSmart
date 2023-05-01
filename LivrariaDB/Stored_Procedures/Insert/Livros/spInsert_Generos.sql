CREATE PROCEDURE spInsert_Generos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Generos (Descricao)
	VALUES (@Descricao);
END
GO