CREATE PROCEDURE spUpdate_Vendas
(
	@Id INT
	,@Data_venda DATETIME
	,@Livraria_Id INT
	,@Cliente_Id INT
)
AS
BEGIN
	
	UPDATE Vendas SET
		Data_venda = @Data_venda
		,Livraria_Id = @Livraria_Id
		,Cliente_Id = @Cliente_Id
	WHERE Id = @Id

END
GO