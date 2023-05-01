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