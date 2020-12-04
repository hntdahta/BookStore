USE [BookStoreDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteBook]    Script Date: 12/4/2020 11:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dat Nguyen
-- Create date: 4/12/2020
-- Description:	Create sp_DeleteBook
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteBook]
	@BookId INT
AS
BEGIN
	DECLARE @Message NVARCHAR(200) ='Something went wrong, please contact administrator.'
	BEGIN TRAN
	BEGIN TRY
	IF(ISNULL(@BookId,0) = 0)
	BEGIN
		SET @Message = 'Book ID is required.'
	END
	ELSE
	BEGIN
		IF (NOT EXISTS (SELECT * FROM BookStoreDB WHERE BookId = @BookId))
		BEGIN
			SET @Message = 'Book is not exists.'
		END
		ELSE
			BEGIN
			IF (EXISTS(SELECT * FROM BookStoreDB WHERE IsDeleted = 1))
			BEGIN
			SET @Message = 'Book already deleted.'
			END
			ELSE
			BEGIN
				UPDATE BookStoreDB
				SET IsDeleted = 1
				WHERE BookId = @BookId
				SET @Message = 'Book has been deleted.'
			END
		END
	END
	SELECT @Message AS [Message], @BookId AS [BookId]
		COMMIT TRAN
	END TRY
	BEGIN CATCH
	SELECT @Message AS [Message], @BookId AS [BookId]
		ROLLBACK TRAN
	END CATCH
END
GO
