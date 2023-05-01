-- Tabela de Livros
-- Referencia um genero literario
-- A capa do Livro está na tabela Capa_Livro

CREATE TABLE Livros
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Genero_Id	INT FOREIGN KEY REFERENCES Generos(Id) NOT NULL

	,Nome VARCHAR(MAX) NOT NULL
	,Sinopse VARCHAR(MAX) NULL
	,Autor VARCHAR(MAX) NOT NULL
	,Editora VARCHAR(MAX) NOT NULL
	,Preco DECIMAL(10,2) NOT NULL
	,Ano_publicacao	INT NOT NULL
)
GO