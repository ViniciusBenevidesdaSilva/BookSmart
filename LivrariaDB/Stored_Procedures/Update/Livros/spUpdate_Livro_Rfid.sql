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