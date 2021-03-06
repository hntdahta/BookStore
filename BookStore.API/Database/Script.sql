USE [master]
GO
/****** Object:  Database [BookStoreDB]    Script Date: 12/4/2020 12:06:37 PM ******/
CREATE DATABASE [BookStoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BookStoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BookStoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BookStoreDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStoreDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStoreDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookStoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [BookStoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStoreDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStoreDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStoreDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookStoreDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BookStoreDB] SET QUERY_STORE = OFF
GO
USE [BookStoreDB]
GO
/****** Object:  Table [dbo].[BookStoreDB]    Script Date: 12/4/2020 12:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookStoreDB](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [nvarchar](500) NOT NULL,
	[Author] [nvarchar](500) NOT NULL,
	[PagesNumber] [int] NOT NULL,
	[YearReleased] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateBook]    Script Date: 12/4/2020 12:06:38 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteBook]    Script Date: 12/4/2020 12:06:38 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetBooks]    Script Date: 12/4/2020 12:06:38 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetDetailBook]    Script Date: 12/4/2020 12:06:38 PM ******/
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
USE [master]
GO
ALTER DATABASE [BookStoreDB] SET  READ_WRITE 
GO
