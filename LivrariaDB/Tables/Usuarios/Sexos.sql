-- Tabela Sexos
-- Usada para padronizar e armazenar os Sexos dos Clientes

CREATE TABLE Sexos
(
	 Id	INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Descricao	VARCHAR(MAX) NOT NULL
)
GO