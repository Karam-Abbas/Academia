create database task5;
use task5;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[Price] [int] NULL,
	[Quantity in Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (100, N'A', 1000, 100)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (200, N'B', 2000, 50)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (300, N'C', 3000, 60)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (400, N'D', 6000, 400)
/****** Object:  Table [dbo].[Courses]    Script Date: 02/17/2017 13:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNo] [varchar](2) NOT NULL,
	[Name] [varchar](30) NULL,
	[City] [varchar](3) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C1', N'AHMED ALI', N'LHR', N'111111')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C2', N'ALI', N'LHR', N'222222')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C3', N'AYESHA', N'LHR', N'333333')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C4', N'BILAL', N'KHI', N'444444')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C5', N'SADAF', N'KHI', N'555555')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C6', N'FARAH', N'ISL', NULL)
/****** Object:  Table [dbo].[Order]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderNo] [int] NOT NULL,
	[CustomerNo] [varchar](2) NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (1, N'C1', CAST(0x7F360B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (2, N'C3', CAST(0x2A3C0B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (3, N'C3', CAST(0x493C0B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (4, N'C4', CAST(0x4A3C0B00 AS Date))
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderNo] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 400, 10)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (2, 200, 5)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (3, 200, 60)

GO
/****** Object:  ForeignKey [FK__OrderDeta__ItemN__4316F928]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
/****** Object:  ForeignKey [FK__OrderDeta__Order__4222D4EF]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderNo])
REFERENCES [dbo].[Order] ([OrderNo])
GO


select * from [Customers]
select * from [Order]
select * from [OrderDetails]
select * from [Items]

CREATE view ordered_items --1
as
select Name 
from Items 
join  OrderDetails on OrderDetails.ItemNo=Items.ItemNo
where OrderDetails.Quantity>Items.[Quantity in Store];

create view trending --2
as
select Name
from Items 
join  OrderDetails on OrderDetails.ItemNo=Items.ItemNo
where OrderDetails.Quantity>30;

Create View pro_cust --3
AS
Select Customers.Name from Customers left join [Order] on Customers.CustomerNo = [Order].CustomerNo left join OrderDetails on [Order].OrderNo=OrderDetails.OrderNo
left join Items on OrderDetails.ItemNo = Items.ItemNo
where Items.Price*OrderDetails.Quantity > 2500;


alter view [pro_cust] --4
AS
Select Customers.CustomerNo,Customers.Name,[Order].Date from Customers,[Order],OrderDetails,Items
where Customers.CustomerNo=[Order].CustomerNo AND [Order].OrderNo=OrderDetails.OrderNo AND OrderDetails.ItemNo=Items.ItemNo AND Items.Price*OrderDetails.Quantity>2500;

create view cust --5
as
select * from Customers;
insert into cust values ('C7','Sana','ISL','121341')
GO

create view not_null --6
as
select * from Customers
where Customers.Phone ='NULL'
with check option
go

create view not_null_without_check --6
as
select * from Customers
where Customers.Phone ='NULL'
go

INSERT INTO not_null_without_check (CustomerNo, Name, City, Phone)
VALUES ('C7', 'Sana', 'ISL', NULL);   ---not letting us insert....

set statistics io on

CREATE VIEW CustomerOrderCounts
WITH SCHEMABINDING
AS
SELECT o.customerNo, od.itemNo, COUNT_BIG(*) AS OrderCount, SUM(od.quantity) AS TotalQuantity
FROM dbo.[Order] o
JOIN dbo.OrderDetails od ON o.orderNo = od.orderNo
GROUP BY o.customerNo, od.itemNo;
GO

create  unique clustered index idx_CustomerOrderCounts on CustomerOrderCounts(customerNo, itemNo)

select*from CustomerOrderCounts;
select*from CustomerOrderCounts with (noexpand)