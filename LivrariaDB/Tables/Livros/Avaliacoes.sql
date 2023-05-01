﻿CREATE TABLE Avaliacoes
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Cliente_Id INT FOREIGN KEY REFERENCES Clientes(Id) ON DELETE CASCADE NOT NULL
	,Livro_Id INT FOREIGN KEY REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL
	
	,Data_Avaliacao DATETIME NOT NULL
	,Nota INT NOT NULL
	,Resenha VARCHAR(MAX) NULL
)
GO