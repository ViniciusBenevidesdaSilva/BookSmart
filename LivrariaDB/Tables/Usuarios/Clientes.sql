-- Tabela Clientes
-- Usada para armazenar usuário NÃO administradores que realizam as compras
-- Todo cliente deve possuir um RFID, um usuário vincula e um SALDO

-- As chaves estrageiras estão configuradas ON DELETE CASCADE
-- Se sua referência for excluída, elas também serão

CREATE TABLE Clientes
(
	 Id	INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Rfid_Id	VARCHAR(16) UNIQUE				-- Validar o tamanho correto do id lido

	,Usuario_Id INT FOREIGN KEY REFERENCES Usuarios(Id) ON DELETE CASCADE NOT NULL
	,Genero_Id	INT FOREIGN KEY REFERENCES Generos(Id)	ON DELETE CASCADE NOT NULL
	,Sexo_Id	INT FOREIGN KEY REFERENCES Sexos(Id)	ON DELETE CASCADE NOT NULL
	,Nome		VARCHAR(MAX)
	,Cpf		VARCHAR(14)  -- Ex: 752.979.360-80
	,Email		VARCHAR(MAX)
	,Telefone	VARCHAR(MAX)
	,Endereco	VARCHAR(MAX)
	,Data_nascimento	DATETIME

	,Saldo		DECIMAL(18, 2)
)
GO