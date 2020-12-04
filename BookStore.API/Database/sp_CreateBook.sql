USE [BookStoreDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateBook]    Script Date: 12/4/2020 11:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
CREATE PROCEDURE [dbo].[sp_CreateBook]
	@BookName NVARCHAR(500),
	@Author NVARCHAR(500),
	@PagesNumber INT,
	@YearReleased INT
AS
BEGIN
	DECLARE @BookId	INT = 0,
			@Message	NVARCHAR(200) = 'Something went wrong, please contact administrator.'

	BEGIN TRY
		IF(@BookName IS NULL OR @BookName = '')
		BEGIN
			SET @Message = 'Book name is required.'
		END
		ELSE
		BEGIN
			IF(@Author IS NULL OR @Author = '')
			BEGIN
				SET @Message ='Author is required.'
			END
			ELSE
			BEGIN
				IF(@PagesNumber IS NULL OR @PagesNumber = '' OR @PagesNumber = 0)
				BEGIN
					SET @Message = 'Pages number is required and above 0.'
				END
				ELSE
				BEGIN
					IF(EXISTS(SELECT * FROM BookStoreDB WHERE BookName = @BookName))
					BEGIN
						SET @Message = 'Book name is exists.'
					END
					ELSE
					BEGIN
						INSERT INTO [dbo].[BookStoreDB]
							   ([BookName]
							   ,[Author]
							   ,[PagesNumber]
							   ,[YearReleased]
							   ,[IsDeleted])
						 VALUES
							   (@BookName
							   ,@Author
							   ,@PagesNumber
							   ,@YearReleased
							   ,0)

						SET @BookId = SCOPE_IDENTITY()
						SET @Message = 'New book has been created!.'
					END
				END
			END
		END
		SELECT @BookId AS BookId, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookId AS BookId, @Message AS [Message]
	END CATCH
END
GO
