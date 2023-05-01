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