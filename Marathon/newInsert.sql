﻿INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (N'A', N'Администратор')
INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (N'K', N'Координатор')
INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (N'R', N'Бегун')

INSERT INTO [dbo].[Gender] ([GenderId], [Gender]) VALUES (1, N'Мужской')
INSERT INTO [dbo].[Gender] ([GenderId], [Gender]) VALUES (2, N'Жунский')

INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [CountyFlag]) VALUES (143600, N'Волоколамск', N'Русский')

INSERT INTO [dbo].[User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (N'a.adkin@dayrep.net', N'a23f47002f3c4b0781b5cf9d20dbd45b578eac4a77623d6f1e13f7c0c45d1ac7', N'AHMAD     ', N'ADKIN     ', N'R         ')
INSERT INTO [dbo].[User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (N'a.aldrich@gmail.com', N'361ae9bc2138117fcaa85c5dd4817a4744f467485e7a96eb08c507f3c13574c4', N'AARON     ', N'ALDRICH   ', N'K         ')
INSERT INTO [dbo].[User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (N'a.allison@gmail.com', N'2fe164d410e9ab892509af016eab9299ae82fd3cbfc6a667b8e3722f8417ceb9', N'ALPHONSO  ', N'ALLISON   ', N'A         ')

INSERT INTO [dbo].[Runner] ([RunnerId], [Email], [Gender], [DateOfBirth], [CountryCode]) VALUES (1, N'a.adkin@dayrep.net', 1, N'2005-08-15', 143600)

INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (1, N'ARISE', N'«Arise» поддерживает женщин и детей, которые пережили насилие в семье, что позволяет им 
вернуться к нормальной жизни. Влияние насилия в семье имеет далеко идущие последствия, и 
влияет на всю семью и может продолжаться в течение нескольких поколений.
На протяжении более 20 лет, ARISE оказывает услуги, которые включают:
Оценка риска и поиск безопасное проживание
Предоставление информации о бытовых услуг, юридические консультации, финансовые 
консультации, услуги здравоохранения и группу поддержки
правовую и судебную поддержку
Поддержка ARISE обеспечивает лучшее будущее для женщин и детей.', N'arise-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (2, N'Aves Do Brasil', N'Вы можете помочь спасти птиц, которые находятся на грани исчезновения, и под угрозой 
исчезновения в дикой природе.
Находящиеся под угрозой исчезновения птицы включают в себя: Крапивник, вишневые горлом и 
земельную кукушку.
Ваши пожертвования могут помочь защитить в Бразилии регион Серрадо, уникальный район 
саванны, где многие в видов риска, найдены', N'aves-do-brazil-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (3, N'Clara Santos Oliveira Institute
', N'Является неправительственной, некоммерческой организацией, основанной в Сан-Паулу. 
Клара основал институт в 1986 году, чтобы обеспечить жильем и образование для молодых 
людей, которые прошли через суд по делам несовершеннолетних. На сегодняшний день 
существует пять домов в Сан-Паулу, и мы хотим, расширить и построить еще три к 2020 году', N'clara-santos-oliveira-institute-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (4, N'Conquer Cancer Brazil', N'Посвящен помощи разработки лечения и создания препаратов для лечения рака 
путем финансирования исследований мирового класса в Бразилии. Мы поднимаем средства 
исключительно для исследований в области профилактики, диагностики и лечения для всех видов 
рака, в центрах по всей Бразилии.
Помогите нам работать, чтобы изменить жизнь миллионов людей к 2020.', N'conquer-cancer-brazil')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (5, N'Diabetes Brazil', N'Стремится снизить влияние диабета посредством образования, раннего выявления и поддержки.
Диабет является ведущей причиной слепоты у взрослых, почечной недостаточности и повышает 
риск сердечных приступов и инсультов до 400%.
Ваша поддержка помогает нам продолжать нашу спасательную работу
', N'diabetes-brazil-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (6, N'Heart Health Sao Paulo', N'Уже более 50 лет, Heart Health Sao Paulo была посвящена спасению жизней, сделав разницу в 
здоровье сердца наших людей. Пожертвования помогают нам финансировать ценные 
исследования, разработать руководящие принципы для медицинских работников, поддерживать 
ухода за пациентами и помочь людям жить здоровым образом жизни.', N'heart-health-sao-paulo-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (7, N'Stay Pumped', N'Является благотворительной организацией, которая помогает пенсионерам профессионального 
спортивна, которые часто испытывают проблемы, с приспособлением к жизни после спорта. 
Многим пенсионерам, не хватает образования и жизненных необходимых навыков,. Они часто 
имеют дополнительное бремя по полученным травмам.
Мы работаем с профессионалами и добровольцами. Мы полагаемся на пожертвования, чтобы 
выполнить эту необходимую работу.
', N'stay-pumoed-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (8, N'Upbeat SP
', N'Является некоммерческой организацией, которая предлагает поддержку для тех, кто 
страдает от расстройств настроения, таких как депрессия и биполярное расстройство. Кроме того 
мы проводим научные исследования, чтобы помочь с пониманием расстройств настроения. Наш 
последний проект помогает использовать технологии, чтобы решить проблемы психического 
здоровья. Мы смотрим на социальных медиа в качестве индикатора психического здоровья, а 
также на использовании мобильных телефонов для измерения психического здоровья.
Помогите нам продолжить большую работу мы делаем.
', N'upbeat-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (9, N'WWSM Rescue
', N'Небольшой организация WWSM посвятила себя сохранению Белый Усатой Паукообразной
Обезьяны. Вырубка лесов и превращение земли для сельского хозяйства серьезно сказалось на 
доме для этой обезьяны. К сожалению, на них также охотились и они были вытеснены на грань 
вымирания.
WWSM нуждается в вашей помощи, чтобы поднять профиль Белый Усатой Паукообразной
Обезьяны в местных сообществах.', N'wwsm-rescue-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (10, N'The Red Cross', N'Помощи в период кризиса, все равно, когда она наиболее необходима, и обязательства, когда 
другие отворачиваются. Красный Крест там для людей в потребности, независимо от того, кто вы 
есть, независимо от того, где вы живете.
Красного Полумесяца движение Красного Креста помогает десятки миллионов людей по всему 
миру каждый год, и мы также заботимся для местных общин в нашей стране местного и дальнего 
зарубежья.
С миллионами добровольцев по всему миру и тысячи членов, волонтеров и сторонников, мы 
можем достичь людей и места, как никто другой.
', N'the-red-cross-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (11, N'Oxfam International', N'Oxfam является Международной конфедерацией 17 организаций, работающих совместно 
с партнерами и местными сообществами в более чем 90 странах мира.
Один человек из трех в мире живет в нищете. Oxfam решил изменить этот мир по 
мобилизации сил народа против бедности.
На всем земном шаре, Oxfam работает, чтобы найти практические пути, инновационные 
для людей, чтобы вырваться из нищеты и процветать. Мы спасаем жизнь и помогаем
восстановить средства к существованию, в период кризиса и забастовок. И мы кампания, так что 
голоса бедных влияния на локальные и глобальные решения, которые их затрагивают.
Во всех мы делаем, Oxfam работает с партнерскими организациями и рядом уязвимых 
женщин и мужчин до конца несправедливости, которые вызывают бедность.
', N'oxfam-international-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (12, N'Save the Children Fund', N'Является ведущей в мире независимой организацией для детей. Мы работаем примерно в 120 
странах мира. Мы спасаем жизни детей; мы боремся за свои права; мы помогаем им реализовать 
свой потенциал.
Мы работаем, чтобы вдохновить прорывов в том, как мир относится к детям и добиться 
немедленного и прочного изменения в их жизни. По всей нашей работы, мы преследуем 
несколько основных значения: подотчетность, амбиции, сотрудничество, творчество и 
целостность.
В 2014 году мы достигли более 55 миллионов детей непосредственно через работы наших и 
наших партнеров.
Пожертвовать сейчас, чтобы помочь нам, как дети мира.
', N'save-the-children-fund-logo')
INSERT INTO [dbo].[Charity] ([CharityId], [ChatityName], [CharityDescription], [CharityLogo]) VALUES (13, N'Querstadtein Berlin', N'querstadtein первый проект Stadtsichten , зарегистрированного некоммерческого объединения.
Хотя видно везде в городе, бездомность редко обсуждается. На теоретическом уровне мы часто 
очень мало знаем о теме, которая перед нами на улицах каждый день. Через querstadtein мы 
хотели бы повысить осведомленность о данной проблеме.
Все началось с желания наших двух основателей, чтобы получить что-то "реальное" с земли в 
Берлине, активно решать проблему, а не просто думать об этом. Бездомные люди, казалось, 
везде, по всему городу и на ежедневных поездок в офис. Некоторые из них были там в день, день, 
в U-Bahn или на улице. Разрыв между бездомных и остальной части общества было 
поразительным. Это где мы хотели быть активным - создать пространство, которое будет 
способствовать встречи, обмен и осведомленность.
Мы хотели бы вашей помощи, чтобы помочь бездомным в Берлине', N'querstadtein')

