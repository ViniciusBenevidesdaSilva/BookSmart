-- Tabela Livro_Rfid
-- Usada para o controle de quais Rfids estão cadastrados para quais livros
-- Usada também para o controle de estoque

CREATE TABLE Livro_Rfid
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL 
	,Livro_Id INT FOREIGN KEY REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL
	,Livraria_Id INT FOREIGN KEY REFERENCES Livrarias(Id) ON DELETE CASCADE NOT NULL

	,Rfid VARCHAR(16) NOT NULL						-- Teoricamente 8 bits
	,Flag_disponivel BIT NOT NULL					-- 0 Vendido | 1 Disponível para compra
)
GO