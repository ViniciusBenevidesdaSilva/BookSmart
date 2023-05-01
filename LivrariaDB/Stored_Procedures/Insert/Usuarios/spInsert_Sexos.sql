CREATE PROCEDURE spInsert_Sexos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Sexos (Descricao)
	VALUES (@Descricao);
END
GO