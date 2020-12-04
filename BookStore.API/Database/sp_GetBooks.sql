USE [BookStoreDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetBooks]    Script Date: 12/4/2020 11:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dat Nguyen
-- Create date: 4/12/2020
-- Description:	Create sp_getbooks
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBooks] 
AS
BEGIN
	SELECT [BookId]
		  ,[BookName]
	  FROM [dbo].[BookStoreDB]
	  WHERE IsDeleted = 0
END
GO
