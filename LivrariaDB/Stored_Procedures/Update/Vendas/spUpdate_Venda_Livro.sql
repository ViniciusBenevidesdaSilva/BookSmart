CREATE PROCEDURE spUpdate_Venda_Livro
(
	@Id INT
	,@Venda_Id INT
	,@Livro_rfid_Id INT
)
AS
BEGIN
	MERGE INTO Venda_Livro AS TARGET

    USING (
		SELECT @Id, @Venda_Id, @Livro_rfid_Id 
		UNION SELECT * FROM Venda_Livro
		  ) AS SOURCE (Id, Venda_Id, Livro_rfid_Id)
    ON TARGET.Id = SOURCE.Id

    WHEN MATCHED THEN
        UPDATE SET 
			Venda_Id = SOURCE.Venda_Id,
			Livro_rfid_Id = SOURCE.Livro_rfid_Id

    WHEN NOT MATCHED THEN
        INSERT (Venda_Id, Livro_rfid_Id) 
		VALUES (SOURCE.Venda_Id, SOURCE.Livro_rfid_Id)

	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END
GO