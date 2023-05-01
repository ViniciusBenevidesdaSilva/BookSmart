-- Tabela de Livrarias
-- Usada para controle de estoque e localidade da compra

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