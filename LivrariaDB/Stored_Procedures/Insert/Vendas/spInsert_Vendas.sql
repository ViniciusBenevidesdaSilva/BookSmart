CREATE PROCEDURE spInsert_Vendas
(
	@Id INT
	,@Data_venda DATETIME
	,@Livraria_Id INT
	,@Cliente_Id INT
)
AS
BEGIN
	INSERT INTO Vendas(Data_venda,Livraria_Id,Cliente_Id)
	VALUES (@Data_venda,@Livraria_Id,@Cliente_Id);
END
GO