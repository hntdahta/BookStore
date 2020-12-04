USE [BookStoreDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDetailBook]    Script Date: 12/4/2020 11:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dat Nguyen
-- Create date: 4/12/2020
-- Description:	Create sp_GetDetailBook
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDetailBook]
	@BookId INT
AS
BEGIN
	DECLARE @Message NVARCHAR(200) = 'Something went wrong, please contact administrator.'
	BEGIN
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
				SELECT * FROM [dbo].[BookStoreDB]
			END
		END
	END
END
	
GO
