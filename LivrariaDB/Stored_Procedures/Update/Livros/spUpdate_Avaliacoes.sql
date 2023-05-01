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