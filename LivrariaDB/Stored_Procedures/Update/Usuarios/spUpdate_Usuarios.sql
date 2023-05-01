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