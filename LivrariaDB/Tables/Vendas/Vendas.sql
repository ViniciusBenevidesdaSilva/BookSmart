-- Tabela de Vendas
-- Armazena os dados gerais da venda, como data, cliente e livraria
-- Não possui delete cascate para não perder os dados históricos da venda

CREATE TABLE Vendas
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Data_venda DATETIME NOT NULL
	,Livraria_Id INT FOREIGN KEY REFERENCES Livrarias(Id) NOT NULL
	,Cliente_Id INT FOREIGN KEY REFERENCES Clientes(Id) NOT NULL
)
GO