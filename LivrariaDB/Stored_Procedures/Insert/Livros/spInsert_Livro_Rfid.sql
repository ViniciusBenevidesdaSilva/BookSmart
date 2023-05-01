CREATE PROCEDURE spInsert_Livro_Rfid
(
	@Id INT
	,@Livro_Id INT
	,@Livraria_Id INT
	,@Rfid VARCHAR(16)
	,@Flag_disponivel BIT
)
AS
BEGIN
	INSERT INTO Livro_Rfid(Livro_Id,Livraria_Id,Rfid,Flag_disponivel)
	VALUES (@Livro_Id,@Livraria_Id,@Rfid,@Flag_disponivel);
END
GO