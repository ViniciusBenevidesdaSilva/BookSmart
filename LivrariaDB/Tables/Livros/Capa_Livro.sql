-- Tabela de imagens das capas dos livros
-- Armazenada de forma separada para não sobrecarregar a busca principal

CREATE TABLE Capa_Livro
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Livro_Id	INT FOREIGN KEY REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL
	,Capa_Livro VARBINARY(MAX) NULL
)
GO