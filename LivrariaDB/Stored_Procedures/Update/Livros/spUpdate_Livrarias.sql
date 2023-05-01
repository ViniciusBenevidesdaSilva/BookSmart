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