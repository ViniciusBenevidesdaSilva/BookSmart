-- Tabela Generos
-- Usada para armazenar os gêneros literários cadastrados

CREATE TABLE Generos
(
	 Id	INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Descricao	VARCHAR(MAX) NOT NULL
)
GO