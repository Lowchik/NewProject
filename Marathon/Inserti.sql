INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Бегун')
INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'Координатор')
INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'Администратор')

INSERT INTO [dbo].[User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (N'a.adkin@dayrep.net', N'a23f47002f3c4b0781b5cf9d20dbd45b578eac4a77623d6f1e13f7c0c45d1ac7', N'AHMAD     ', N'ADKIN     ', 1)
INSERT INTO [dbo].[User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (N'a.aldrich@gmail.com', N'361ae9bc2138117fcaa85c5dd4817a4744f467485e7a96eb08c507f3c13574c4', N'AARON     ', N'ALDRICH   ', 2)
INSERT INTO [dbo].[User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (N'a.allison@gmail.com', N'2fe164d410e9ab892509af016eab9299ae82fd3cbfc6a667b8e3722f8417ceb9', N'ALPHONSO  ', N'ALLISON   ', 3)
