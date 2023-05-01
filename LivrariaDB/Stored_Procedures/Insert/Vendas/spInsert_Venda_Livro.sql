CREATE PROCEDURE spInsert_Venda_Livro
(
	@Id INT
	,@Venda_Id INT
	,@Livro_rfid_Id INT
)
AS
BEGIN
	INSERT INTO Venda_Livro(Venda_Id,Livro_rfid_Id)
	VALUES (@Venda_Id,@Livro_rfid_Id);
END
GO