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