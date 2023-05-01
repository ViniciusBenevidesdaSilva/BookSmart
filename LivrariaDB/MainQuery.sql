-- Criação Geral dos dados do banco LivrariaDB

-- Exclusão do banco como um todo
-- Pode-se comentar essa parte caso não seja necessário
/*
USE master
GO

DROP DATABASE IF EXISTS LivrariaDB
GO

CREATE DATABASE LivrariaDB
GO
*/

USE LivrariaDB
GO



-- Criação das Tabelas
DROP TABLE IF EXISTS Venda_Livro
DROP TABLE IF EXISTS Vendas
DROP TABLE IF EXISTS Avaliacoes
DROP TABLE IF EXISTS Clientes
DROP TABLE IF EXISTS Sexos
DROP TABLE IF EXISTS Usuarios
DROP TABLE IF EXISTS Livro_Rfid
DROP TABLE IF EXISTS Livrarias
DROP TABLE IF EXISTS Capa_Livro
DROP TABLE IF EXISTS Livros
DROP TABLE IF EXISTS Generos
GO

-- Livros
CREATE TABLE Generos
(
	 Id	INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Descricao	VARCHAR(MAX) NOT NULL
)
GO
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
CREATE TABLE Capa_Livro
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Livro_Id	INT FOREIGN KEY REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL
	,Capa_Livro VARBINARY(MAX) NULL
)
GO
CREATE TABLE Livrarias
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Nome VARCHAR(MAX) NOT NULL
	,CNPJ VARCHAR(18)  -- Ex: 58.797.499/0001-90

	-- Dados de endereço
	,CEP VARCHAR(9)  -- Ex: 72318-010   -- https://viacep.com.br/ws/72318010/json/
	,UF VARCHAR(2)
	,Cidade VARCHAR(MAX)
	,Bairro VARCHAR(MAX)
	,Logradouro VARCHAR(MAX)
	,Numero VARCHAR(MAX)   -- Algumas cadas permitem 57A por exemplo
)
GO
CREATE TABLE Livro_Rfid
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL 
	,Livro_Id INT FOREIGN KEY REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL
	,Livraria_Id INT FOREIGN KEY REFERENCES Livrarias(Id) ON DELETE CASCADE NOT NULL

	,Rfid VARCHAR(16) NOT NULL						-- Teoricamente 8 bits
	,Flag_disponivel BIT NOT NULL					-- 0 Vendido | 1 Disponível para compra
)
GO
-- Clientes
CREATE TABLE Usuarios
(
	 Id				INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,name_user		VARCHAR(50) UNIQUE NOT NULL			-- Não pode haver repetição de nome de usuário
	,hash_password	VARBINARY(64) NOT NULL				-- Armazena a senha criptografada em formato HASH
	,salt_password	UNIQUEIDENTIFIER NOT NULL			-- SALT usado para validar a senha do usuário
	,user_type		BIT NOT NULL						-- 0 cliente | 1 adm
	,flag_ativo		BIT NOT NULL						-- 0 Inativo | 1 ativo
)
GO
CREATE TABLE Sexos
(
	 Id	INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Descricao	VARCHAR(MAX) NOT NULL
)
GO
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
CREATE TABLE Avaliacoes
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Cliente_Id INT FOREIGN KEY REFERENCES Clientes(Id) ON DELETE CASCADE NOT NULL
	,Livro_Id INT FOREIGN KEY REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL
	
	,Data_Avaliacao DATETIME NOT NULL
	,Nota INT NOT NULL
	,Resenha VARCHAR(MAX) NULL
)
GO
-- Vendas
CREATE TABLE Vendas
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Data_venda DATETIME NOT NULL
	,Livraria_Id INT FOREIGN KEY REFERENCES Livrarias(Id) NOT NULL
	,Cliente_Id INT FOREIGN KEY REFERENCES Clientes(Id) NOT NULL
)
GO
CREATE TABLE Venda_Livro
(
	 Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,Venda_Id INT FOREIGN KEY REFERENCES Vendas(Id) ON DELETE CASCADE NOT NULL
	,Livro_rfid_Id INT FOREIGN KEY REFERENCES Livro_Rfid(Id) NOT NULL
)
GO

-- Criação das View
DROP VIEW IF EXISTS VW_Estoque
GO
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


-- Criação das Procedures
DROP PROCEDURE IF EXISTS spConsulta
DROP PROCEDURE IF EXISTS spDelete
DROP PROCEDURE IF EXISTS spListagem
DROP PROCEDURE IF EXISTS spProximoId
DROP PROCEDURE IF EXISTS spPesquisa_Usuarios
DROP PROCEDURE IF EXISTS spListagem_Livros
DROP PROCEDURE IF EXISTS spListagem_Foreign
DROP PROCEDURE IF EXISTS spInsert_Avaliacoes
DROP PROCEDURE IF EXISTS spInsert_Capa_Livro
DROP PROCEDURE IF EXISTS spInsert_Generos
DROP PROCEDURE IF EXISTS spInsert_Livrarias
DROP PROCEDURE IF EXISTS spInsert_Livro_Rfid
DROP PROCEDURE IF EXISTS spInsert_Livros
DROP PROCEDURE IF EXISTS spInsert_Venda_Livro
DROP PROCEDURE IF EXISTS spInsert_Vendas
DROP PROCEDURE IF EXISTS spInsert_Sexos
DROP PROCEDURE IF EXISTS spInsert_Clientes
DROP PROCEDURE IF EXISTS spInsert_Usuarios
DROP PROCEDURE IF EXISTS spUpdate_Avaliacoes
DROP PROCEDURE IF EXISTS spUpdate_Capa_Livro
DROP PROCEDURE IF EXISTS spUpdate_Generos
DROP PROCEDURE IF EXISTS spUpdate_Livrarias
DROP PROCEDURE IF EXISTS spUpdate_Livro_Rfid
DROP PROCEDURE IF EXISTS spUpdate_Livros
DROP PROCEDURE IF EXISTS spUpdate_Venda_Livro
DROP PROCEDURE IF EXISTS spUpdate_Vendas
DROP PROCEDURE IF EXISTS spUpdate_Sexos
DROP PROCEDURE IF EXISTS spUpdate_Clientes
DROP PROCEDURE IF EXISTS spUpdate_Usuarios
GO
-- Padrao
CREATE PROCEDURE spConsulta
(
	 @Id INT
	,@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @Tabela 
			+ ' WHERE id = ' + CONVERT(VARCHAR(MAX), @Id)
	EXEC(@sql)
END
GO
CREATE PROCEDURE spDelete
(
	 @Id INT
	,@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'DELETE ' + @Tabela
			+ ' WHERE id = ' + CONVERT(VARCHAR(MAX), @Id)
	EXEC(@sql)
END
GO
CREATE PROCEDURE spListagem
(
	@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @Tabela
	EXEC(@sql)
END
GO
CREATE PROCEDURE spProximoId
(
	@Tabela VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT ISNULL(IDENT_CURRENT(''' + @Tabela + '''),1) AS Id'
	EXEC(@sql)
END
GO

-- Personalizadas

-- Valida se o login e senha passados são válidos, 
-- selecionando o usuário correspondente
CREATE PROCEDURE spPesquisa_Usuarios
(
    @name_user NVARCHAR(50),
    @password NVARCHAR(50)
)

AS

BEGIN
    SET NOCOUNT ON;

    DECLARE @senha_salt NVARCHAR(200);
    DECLARE @hash VARBINARY(64);
    DECLARE @salt UNIQUEIDENTIFIER;

    -- Busca o hash e o salt correspondentes ao login fornecido
    SELECT 
		@hash = hash_password, @salt = salt_password
	FROM 
		Usuarios
    WHERE name_user = @name_user

    -- Se nenhum usuário foi encontrado com o login fornecido
    IF @hash IS NULL
    BEGIN
		-- Realiza a seleção vazia para validar que o usuário não existe
		SELECT NULL AS [name_user]
		RETURN
    END

    -- Combine a senha fornecida com o salt correspondente
    SET @senha_salt = @password + CAST(@salt AS NVARCHAR(36));

    -- Calcule o hash da senha + salt e verifique se é igual ao hash armazenado na tabela de usuários
    IF HASHBYTES('SHA2_256', @senha_salt) = @hash

	-- Login Bem sucedido
    BEGIN
		
		-- Retorna o usuário Selecionado
        SELECT *
		FROM Usuarios
		WHERE name_user = @name_user

    END

	-- Senha inválida
    ELSE
    BEGIN
		SELECT * FROM Usuarios WHERE 1 <> 1
    END

END
GO
-- Realiza a pesquisa de livros ordenando por genero e nota (avaliação)
CREATE PROCEDURE spListagem_Livros
(
	@Genero_Id INT
)
AS

BEGIN

	SELECT 
		l.*
		,AVG(ISNULL(a.Nota,0)) AS [Nota]
    FROM 
		Livros l
    LEFT JOIN 
		Avaliacoes a ON l.Id = a.Livro_Id

	GROUP BY 
		l.[Id]
		,l.[Genero_Id]
		,l.[Nome]
		,l.[Sinopse]
		,l.[Autor]
		,l.[Editora]
		,l.[Preco]
		,l.[Ano_publicacao]
    ORDER BY 
		CASE 
			WHEN l.Genero_Id = @Genero_Id THEN 0 
			ELSE 1 END, 
		AVG(ISNULL(a.Nota,0))
		DESC

END
GO
-- Realiza a pesquisa de relacionamentos muitos para 1, a partir de uma chave estrangeira desejada
CREATE PROCEDURE spListagem_Foreign
(
	@Tabela VARCHAR(MAX)
	,@ForeignKeyName VARCHAR(MAX)
	,@Foreign_Id INT
)
AS
BEGIN
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT * FROM ' + @Tabela
			+ ' WHERE ' + @ForeignKeyName + ' = ' + CAST(@Foreign_Id AS VARCHAR(MAX)) 
	EXEC(@sql)
END
GO

-- Insert
CREATE PROCEDURE spInsert_Avaliacoes
(
	@Id INT
	,@Cliente_Id INT
	,@Livro_Id INT
	,@Data_Avaliacao DATETIME
	,@Nota INT
	,@Resenha VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Avaliacoes(Cliente_Id,Livro_Id,Data_Avaliacao,Nota,Resenha)
	VALUES (@Cliente_Id,@Livro_Id,@Data_Avaliacao,@Nota,@Resenha);
END
GO
CREATE PROCEDURE spInsert_Capa_Livro
(
	@Id INT
	,@Livro_Id	INT
	,@Capa_Livro VARBINARY(MAX)
)
AS
BEGIN
	INSERT INTO Capa_Livro(Livro_Id,Capa_Livro)
	VALUES (@Livro_Id,@Capa_Livro);
END
GO
CREATE PROCEDURE spInsert_Generos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Generos (Descricao)
	VALUES (@Descricao);
END
GO
CREATE PROCEDURE spInsert_Livrarias
(
	@Id INT
	,@Nome VARCHAR(MAX)
	,@CNPJ VARCHAR(18)
	,@CEP VARCHAR(9)
	,@UF VARCHAR(2)
	,@Cidade VARCHAR(MAX)
	,@Bairro VARCHAR(MAX)
	,@Logradouro VARCHAR(MAX)
	,@Numero VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Livrarias(Nome,CNPJ,CEP,UF,Cidade,Bairro,Logradouro,Numero)
	VALUES (@Nome,@CNPJ,@CEP,@UF,@Cidade,@Bairro,@Logradouro,@Numero);
END
GO
CREATE PROCEDURE spInsert_Livro_Rfid
(
	@Id INT
	,@Livro_Id INT
	,@Livraria_Id INT
	,@Rfid VARCHAR(16)
	,@Flag_disponivel BIT
)
AS
BEGIN
	INSERT INTO Livro_Rfid(Livro_Id,Livraria_Id,Rfid,Flag_disponivel)
	VALUES (@Livro_Id,@Livraria_Id,@Rfid,@Flag_disponivel);
END
GO
CREATE PROCEDURE spInsert_Livros
(
	@Id INT
	,@Genero_Id	INT
	,@Nome VARCHAR(MAX)
	,@Sinopse VARCHAR(MAX)
	,@Autor VARCHAR(MAX)
	,@Editora VARCHAR(MAX)
	,@Preco DECIMAL(10,2)
	,@Ano_publicacao INT
)
AS
BEGIN
	INSERT INTO Livros(Genero_Id,Nome,Sinopse,Autor,Editora,Preco,Ano_publicacao)
	VALUES (@Genero_Id,@Nome,@Sinopse,@Autor,@Editora,@Preco,@Ano_publicacao);
END
GO
CREATE PROCEDURE spInsert_Venda_Livro
(
	@Id INT
	,@Venda_Id INT
	,@Livro_rfid_Id INT
)
AS
BEGIN
	INSERT INTO Venda_Livro(Venda_Id,Livro_rfid_Id)
	VALUES (@Venda_Id,@Livro_rfid_Id);
END
GO
CREATE PROCEDURE spInsert_Vendas
(
	@Id INT
	,@Data_venda DATETIME
	,@Livraria_Id INT
	,@Cliente_Id INT
)
AS
BEGIN
	INSERT INTO Vendas(Data_venda,Livraria_Id,Cliente_Id)
	VALUES (@Data_venda,@Livraria_Id,@Cliente_Id);
END
GO
CREATE PROCEDURE spInsert_Sexos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN
	INSERT INTO Sexos (Descricao)
	VALUES (@Descricao);
END
GO
CREATE PROCEDURE spInsert_Clientes
(
	 @Id	INT
	,@Rfid_Id	VARCHAR(16)
	,@Usuario_Id INT
	,@Genero_Id	INT
	,@Sexo_Id	INT
	,@Nome		VARCHAR(MAX)
	,@Cpf		VARCHAR(14)
	,@Email		VARCHAR(MAX)
	,@Telefone	VARCHAR(MAX)
	,@Endereco	VARCHAR(MAX)
	,@Data_nascimento	DATETIME
	,@Saldo		DECIMAL(18, 2)
)
AS
BEGIN
	INSERT INTO Clientes(Rfid_Id,Usuario_Id,Genero_Id,Sexo_Id,Nome,Cpf,Email,Telefone,Endereco,Data_nascimento,Saldo)
	VALUES (@Rfid_Id,@Usuario_Id,@Genero_Id,@Sexo_Id,@Nome,@Cpf,@Email,@Telefone,@Endereco,@Data_nascimento,@Saldo);
END
GO
-- Insere um usuário na tabela, encriptografando a senha
CREATE PROCEDURE spInsert_Usuarios
(
	 @id		INT  -- Passado por parametro mas não usado
	,@name_user	VARCHAR(50)
	,@password	VARCHAR(50)
	,@user_type	BIT
	,@flag_ativo BIT
)
AS
BEGIN
	-- Defina o salt
	DECLARE @salt UNIQUEIDENTIFIER = NEWID();
	
	-- Combine a senha e o salt
	DECLARE @salt_password NVARCHAR(200) = @password + CAST(@salt AS NVARCHAR(36));
	
	-- Crie o hash SHA-256 da senha + salt
	DECLARE @hash_password VARBINARY(64) = HASHBYTES('SHA2_256', @salt_password);
	
	-- Inserir os dados
	INSERT INTO Usuarios (name_user, hash_password, salt_password, user_type, flag_ativo)
	VALUES (@name_user, @hash_password, @salt, @user_type, 1);
END
GO

-- Update
CREATE PROCEDURE spUpdate_Avaliacoes
(
	@Id INT
	,@Cliente_Id INT
	,@Livro_Id INT
	,@Data_Avaliacao DATETIME
	,@Nota INT
	,@Resenha VARCHAR(MAX)
)
AS
BEGIN
	MERGE INTO Avaliacoes AS TARGET

    USING (
		SELECT @Id, @Cliente_Id, @Livro_Id, @Data_Avaliacao, @Nota, @Resenha
		UNION SELECT * FROM Avaliacoes
		  ) AS SOURCE (Id, Cliente_Id, Livro_Id, Data_Avaliacao, Nota, Resenha)
    ON TARGET.Id = SOURCE.Id

    WHEN MATCHED THEN
        UPDATE SET 
			Cliente_Id = SOURCE.Cliente_Id
			,Livro_Id = SOURCE.Livro_Id
			,Data_Avaliacao = SOURCE.Data_Avaliacao
			,Nota = SOURCE.Nota
			,Resenha = SOURCE.Resenha

    WHEN NOT MATCHED THEN
        INSERT (Cliente_Id, Livro_Id, Data_Avaliacao, Nota, Resenha) 
		VALUES (SOURCE.Cliente_Id, SOURCE.Livro_Id, SOURCE.Data_Avaliacao, SOURCE.Nota, SOURCE.Resenha)

	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END
GO
CREATE PROCEDURE spUpdate_Capa_Livro
(
	@Id INT
	,@Livro_Id	INT
	,@Capa_Livro VARBINARY(MAX)
)
AS
BEGIN
	
	UPDATE Capa_Livro SET 
		Livro_Id= @Livro_Id
		,Capa_Livro = @Capa_Livro
	WHERE Id = @Id

END
GO
CREATE PROCEDURE spUpdate_Generos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN

	UPDATE Generos SET
		Descricao = @Descricao
	WHERE Id = @Id

END
GO
CREATE PROCEDURE spUpdate_Livrarias
(
	@Id INT
	,@Nome VARCHAR(MAX)
	,@CNPJ VARCHAR(18)
	,@CEP VARCHAR(9)
	,@UF VARCHAR(2)
	,@Cidade VARCHAR(MAX)
	,@Bairro VARCHAR(MAX)
	,@Logradouro VARCHAR(MAX)
	,@Numero VARCHAR(MAX)
)
AS
BEGIN
	
	UPDATE Livrarias SET
		Nome = @Nome
		,CNPJ = @CNPJ
		,CEP = @CEP
		,UF = @UF
		,Cidade = @Cidade
		,Bairro = @Bairro
		,Logradouro = @Logradouro
		,Numero = @Numero
	WHERE Id = @Id

END
GO
CREATE PROCEDURE spUpdate_Livro_Rfid
(
	@Id INT
	,@Livro_Id INT
	,@Livraria_Id INT
	,@Rfid VARCHAR(16)
	,@Flag_disponivel BIT
)
AS
BEGIN
	
	MERGE INTO Livro_Rfid AS TARGET

    USING (
		SELECT @Id, @Livro_Id, @Livraria_Id, @Rfid, @Flag_disponivel
		UNION SELECT * FROM Livro_Rfid
		  ) AS SOURCE (Id, Livro_Id, Livraria_Id, Rfid, Flag_disponivel)
    ON TARGET.Id = SOURCE.Id

    WHEN MATCHED THEN
        UPDATE SET 
			Livro_Id = SOURCE.Livro_Id
			,Livraria_Id = SOURCE.Livraria_Id
			,Rfid = SOURCE.Rfid
			,Flag_disponivel = SOURCE.Flag_disponivel

    WHEN NOT MATCHED THEN
        INSERT (Id, Livro_Id, Livraria_Id, Rfid, Flag_disponivel) 
		VALUES (SOURCE.Id, SOURCE.Livro_Id, SOURCE.Livraria_Id, SOURCE.Rfid, SOURCE.Flag_disponivel)

	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;

END
GO
CREATE PROCEDURE spUpdate_Livros
(
	@Id INT
	,@Genero_Id	INT
	,@Nome VARCHAR(MAX)
	,@Sinopse VARCHAR(MAX)
	,@Autor VARCHAR(MAX)
	,@Editora VARCHAR(MAX)
	,@Preco DECIMAL(10,2)
	,@Ano_publicacao INT
)
AS
BEGIN
	
	UPDATE Livros SET 
		Genero_Id= @Genero_Id
		,Nome = @Nome
		,Sinopse = @Sinopse
		,Autor = @Autor
		,Editora = @Editora
		,Preco = @Preco
		,Ano_publicacao = @Ano_publicacao
	WHERE Id = @Id

END
GO
CREATE PROCEDURE spUpdate_Clientes
(
	 @Id	INT
	,@Rfid_Id	VARCHAR(16)
	,@Usuario_Id INT
	,@Genero_Id	INT
	,@Sexo_Id	INT
	,@Nome		VARCHAR(MAX)
	,@Cpf		VARCHAR(14)
	,@Email		VARCHAR(MAX)
	,@Telefone	VARCHAR(MAX)
	,@Endereco	VARCHAR(MAX)
	,@Data_nascimento	DATETIME
	,@Saldo		DECIMAL(18, 2)
)
AS
BEGIN
	
	UPDATE Clientes SET
		Rfid_Id = @Rfid_Id
		,Usuario_Id = @Usuario_Id
		,Genero_Id = @Genero_Id
		,Sexo_Id = @Sexo_Id
		,Nome = @Nome
		,Cpf = @Cpf
		,Email = @Email
		,Telefone = @Telefone
		,Endereco = @Endereco
		,Data_nascimento = @Data_nascimento
		,Saldo = @Saldo
	WHERE Id = @Id

END
GO
CREATE PROCEDURE spUpdate_Sexos
(
	 @Id		INT
	,@Descricao	VARCHAR(MAX)
)
AS
BEGIN
	
	UPDATE Sexos SET
		Descricao = @Descricao
	WHERE Id = @Id

END
GO
CREATE PROCEDURE spUpdate_Usuarios
(
	 @id		INT
	,@name_user	VARCHAR(50)
	,@password	VARCHAR(50)
	,@user_type		BIT
	,@flag_ativo BIT
)
AS
BEGIN

	-- Defina o novo salt
	DECLARE @salt UNIQUEIDENTIFIER = NEWID();
	
	-- Combine a senha e o salt
	DECLARE @salt_password NVARCHAR(200) = @password + CAST(@salt AS NVARCHAR(36));
	
	-- Crie o hash SHA-256 da senha + salt
	DECLARE @hash_password VARBINARY(64) = HASHBYTES('SHA2_256', @salt_password);
	
	
	-- Inserir os dados
	UPDATE Usuarios SET
		name_user = @name_user
		,hash_password = @hash_password
		,salt_password = @salt
		,user_type = @user_type
		,flag_ativo = @flag_ativo
	WHERE Id = @id

END
GO
CREATE PROCEDURE spUpdate_Venda_Livro
(
	@Id INT
	,@Venda_Id INT
	,@Livro_rfid_Id INT
)
AS
BEGIN
	MERGE INTO Venda_Livro AS TARGET

    USING (
		SELECT @Id, @Venda_Id, @Livro_rfid_Id 
		UNION SELECT * FROM Venda_Livro
		  ) AS SOURCE (Id, Venda_Id, Livro_rfid_Id)
    ON TARGET.Id = SOURCE.Id

    WHEN MATCHED THEN
        UPDATE SET 
			Venda_Id = SOURCE.Venda_Id,
			Livro_rfid_Id = SOURCE.Livro_rfid_Id

    WHEN NOT MATCHED THEN
        INSERT (Venda_Id, Livro_rfid_Id) 
		VALUES (SOURCE.Venda_Id, SOURCE.Livro_rfid_Id)

	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END
GO
CREATE PROCEDURE spUpdate_Vendas
(
	@Id INT
	,@Data_venda DATETIME
	,@Livraria_Id INT
	,@Cliente_Id INT
)
AS
BEGIN
	
	UPDATE Vendas SET
		Data_venda = @Data_venda
		,Livraria_Id = @Livraria_Id
		,Cliente_Id = @Cliente_Id
	WHERE Id = @Id

END
GO

-- Insere valores default para teste
BEGIN

EXEC spInsert_Usuarios 1,'Benevides','123456',1,1
EXEC spInsert_Usuarios 2,'Analuz','007',0,1
EXEC spInsert_Usuarios 3,'Marcelly','160702',0,1
INSERT INTO Sexos ([Descricao])
VALUES	('Feminino'),
		('Masculino')
INSERT INTO Generos ([Descricao])
VALUES	('Romance'),
		('Aventura'),
		('Suspense'),
		('Infantil'),
		('Terror'),
		('Poesia'),
		('Cordel')
INSERT INTO Clientes ([Rfid_Id],[Usuario_Id],[Genero_Id],[Sexo_Id],[Nome],[Cpf],[Email],[Telefone],[Endereco],[Data_nascimento],[Saldo])
VALUES	('10 10 10 10',2,1,1,'Analuz Ramos','823.909.660-39','analuz@gmail.com',NULL,NULL,'01/09/2003',500),
		('20 20 20 20',3,2,1,'Marcelly Molinari Marsura','388.529.340-49',NULL,NULL,NULL,'05/11/2002',1000)
INSERT INTO Livrarias ([Nome],[CNPJ],[CEP],[UF],[Cidade],[Bairro],[Logradouro],[Numero])
VALUES	('Livraria CEFSA','59.107.300/0001-17','09850-550','SP','São Bernardo do Campo','Assunção','Estrada dos Alvarengas','4002'),
		('Livraria UFABC','07.722.779/0001-06','09606-070','SP','São Bernardo do Campo','Anchieta','Rua Arcturus','5001')
INSERT INTO Livros ([Genero_Id],[Nome],[Sinopse],[Autor],[Editora],[Preco],[Ano_publicacao])
VALUES	(1,'Orgulho e Preconceito','O romance se passa no final do século XVIII e gira em torno do relacionamento entre Elizabeth Bennet e Mr. Darcy, um homem rico e orgulhoso.','Jane Austen','Martin Claret',19.99,1813),
		(1,'A Culpa é das Estrelas','A história acompanha a jornada de Hazel Grace, uma adolescente que luta contra um câncer, e seu romance com Augustus Waters, outro paciente com quem ela conhece em um grupo de apoio.','John Green','Intrínseca',27.43,2012),
		(2,'A Ilha do Tesouro','O livro conta a história de Jim Hawkins, um jovem que descobre um mapa que leva a um tesouro escondido e embarca em uma jornada perigosa para encontrá-lo.','Robert Louis Stevenson','Zahar',17.99,1883),
		(2,'Percy Jackson e o Ladrão de Raios','O livro apresenta o jovem Percy Jackson, que descobre ser um semideus e embarca em uma missão para recuperar o raio de Zeus que foi roubado.','Rick Riordan','Intrínseca',44.99,2005),
		(3,'O Código Da Vinci','O livro gira em torno da descoberta de um segredo por trás do Santo Graal e da jornada do simbologista Robert Langdon para desvendar o mistério.','Dan Brown','Arqueiro',42.77,2003),
		(3,'A Garota no Trem','O livro segue a história de Rachel, uma mulher que fica obcecada com a vida de um casal que ela observa da janela do trem todos os dias e se envolve em um mistério envolvendo um desaparecimento.','Paula Hawkins','Record',39.90,2015),
		(4,'O Pequeno Príncipe','A história acompanha a jornada de um jovem príncipe em busca de amigos e aventuras em diferentes planetas.','Antoine de Saint-Exupéry','Agir',8.99,1943),
		(4,'O Ursinho Pooh','O livro apresenta o ursinho Pooh e seus amigos em uma série de histórias divertidas e cativantes.','A. A. Milne','WMF Martins Fontes',36.21,1926),
		(5,'O Iluminado','A história segue a vida de Jack Torrance, um escritor que se torna zelador do Overlook Hotel no Colorado, e sua família, que são atormentados por eventos sobrenaturais no hotel.','Stephen King','Suma',39.99,1977),
		(5,'Frankenstein','O livro gira em torno do Dr. Victor Frankenstein, que cria uma criatura monstruosa em um experimento e luta para lidar com as consequências de sua criação.','Mary Shelley','Martin Claret',15.99,1818),
		(6,'Antologia Poética','Coletânea de poemas de Carlos Drummond de Andrade, um dos principais nomes da poesia brasileira.','Carlos Drummond de Andrade','Companhia das Letras',38.90,1951),
		(6,'Morte e Vida Severina','Poema de João Cabral de Melo Neto que narra a jornada de Severino, um retirante nordestino, em busca de uma vida melhor.','João Cabral de Melo Neto','Alfaguara',35.80,1956),
		(7,'O Romance da Pedra do Reino e o Príncipe do Sangue do Vai-e-Volta','Romance em cordel de Ariano Suassuna que mistura elementos da cultura popular nordestina e da literatura de cavalaria.','Ariano Suassuna','Nova Fronteira',59.90,1971),
		(7,'O Cachorro dos Mortos','História em cordel de Marco Haurélio que conta a história de um cachorro que é ressuscitado por seu dono e se vinga de seus assassinos.','Marco Haurélio','Escala Educacional',11.99,2002)
INSERT INTO Avaliacoes ([Cliente_Id],[Livro_Id],[Data_Avaliacao],[Nota],[Resenha])
VALUES	(1,1,'28/10/2022',5,'O livro é simplesmente encantador, amei a capa dura dele, a ilustração do livro muito delicada e discreta, superou minha expectativa, tenho certeza que quem for comprar não irá se arrepender.'),
		(2,1,'09/03/2023',3,NULL),
		(1,2,'13/11/2021',5,'Amo o filme e finalmente vou poder ler o livro'),
		(2,2,'27/01/2023',4,'Não importa quantas vezes eu leia, sempre vou me emocionar muito.'),
		(1,4,'10/07/2021',4,'Ótimo livro, amo demais mitologia grega e Percy é otimo pra quem gosta'),
		(2,5,'27/11/2022',5,NULL),
		(1,6,'25/02/2023',0,NULL),
		(2,6,'29/02/2020',1,'Generico demais'),
		(2,7,'28/01/2020',4,'Melhor Livro já escrito!'),
		(1,8,'21/01/2022',2,'Definitivamente é um livro'),
		(1,9,'03/02/2021',5,'Obra prima atemporal'),
		(2,9,'21/07/2021',5,'Ápice da escrita modern'),
		(1,10,'21/02/2020',4,'Definitivamente também é um livro'),
		(1,11,'01/12/2020',5,'Não consigo descrever o quão incrivel foi ler essa antologia!'),
		(1,12,'01/04/2020',3,'Pelo menos o titulo é engraçado'),
		(1,13,'16/08/2021',5,'Quem diria que ler um cordel seria tão legal')
INSERT INTO Livro_Rfid ([Livro_Id],[Livraria_Id],[Rfid],[Flag_disponivel])
VALUES	(1,1,'30 30 30 30',1),
		(1,1,'40 40 40 40',1),
		(1,1,'50 50 50 50',0),
		(2,1,'60 60 60 60',1),
		(2,2,'70 70 70 70',1),
		(2,1,'80 80 80 80',0)
INSERT INTO Vendas ([Data_venda],[Livraria_Id],[Cliente_Id])
VALUES	 ('30/04/2023',1,1)
INSERT INTO Venda_Livro ([Venda_Id],[Livro_rfid_Id])
VALUES	(1,3),
		(1,3)

END