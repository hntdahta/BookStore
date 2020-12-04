USE [BookStoreDB]
GO
SET IDENTITY_INSERT [dbo].[BookStoreDB] ON 

INSERT [dbo].[BookStoreDB] ([BookId], [BookName], [Author], [PagesNumber], [YearReleased], [IsDeleted]) VALUES (1, N'Ki luat mem cua trai tim', N'Nguyen Thi Thu', 268, 2020, 0)
INSERT [dbo].[BookStoreDB] ([BookId], [BookName], [Author], [PagesNumber], [YearReleased], [IsDeleted]) VALUES (4, N'Hoc cho ai? Hoc de lam gi?', N'Tieu Ve', 176, 2020, 0)
INSERT [dbo].[BookStoreDB] ([BookId], [BookName], [Author], [PagesNumber], [YearReleased], [IsDeleted]) VALUES (5, N'Phong cach song - FRILUFTSLIV ', N'Cindy Tran', 60, 2019, 0)
INSERT [dbo].[BookStoreDB] ([BookId], [BookName], [Author], [PagesNumber], [YearReleased], [IsDeleted]) VALUES (6, N'Tram cam - Sat thu tham lang', N'Nguyen Thanh Ha', 140, 2020, 0)
INSERT [dbo].[BookStoreDB] ([BookId], [BookName], [Author], [PagesNumber], [YearReleased], [IsDeleted]) VALUES (7, N'Toi tin toi co the lam duoc - Hoc cach lam viec', N'Chu Nam Hieu', 192, 2020, 0)
INSERT [dbo].[BookStoreDB] ([BookId], [BookName], [Author], [PagesNumber], [YearReleased], [IsDeleted]) VALUES (8, N'Tro ve tuoi tho', N'Ton Duc Thang', 223, 2018, 1)
SET IDENTITY_INSERT [dbo].[BookStoreDB] OFF
GO
