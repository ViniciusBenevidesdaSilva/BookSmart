-- Tabela Venda_Livro
-- Armazena quais livros foram comprados em cada venda

CREATE TABLE Venda_Livro
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Venda_Id INT FOREIGN KEY REFERENCES Vendas(Id) ON DELETE CASCADE NOT NULL
	,Livro_rfid_Id INT FOREIGN KEY REFERENCES Livro_Rfid(Id) NOT NULL
)
GO
