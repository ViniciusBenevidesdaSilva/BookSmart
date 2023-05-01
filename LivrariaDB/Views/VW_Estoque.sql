-- View Estoque
-- Essa view agregará todos os livros e suas quantidades em cada loja
-- Assim que um novo livro_rfid for cadastrado, 
-- essa view já será atualizada com o novo produto em estoque

CREATE VIEW VW_Estoque
AS 

	SELECT 
		 Livro_Id
		,Livraria_Id
		,COUNT(Rfid) AS [Quantidade]

	FROM 
		dbo.Livro_Rfid

	WHERE 
		Flag_disponivel = 1

	GROUP BY 
		 Livro_Id
		,Livraria_Id

GO
