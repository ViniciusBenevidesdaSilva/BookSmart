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