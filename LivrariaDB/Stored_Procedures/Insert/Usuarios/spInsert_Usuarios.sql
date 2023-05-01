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