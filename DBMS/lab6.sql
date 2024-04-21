create database labtask;
use labtask;

create table [UserType](
[userTypeId] int primary key,
[name] varchar(20) not null
)
go
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType([userTypeId]),
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go
create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go

Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go

create table TransactionType(
[transTypeID] int primary key,
[typeName] varchar(15),
[description] varchar(40) null
)

go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)


go
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (4, N'Common')
GO

INSERT [dbo].[User] ([userId], [name], [userType],[phoneNum], [city]) VALUES (1, N'Ali',2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name],  [userType],[phoneNum], [city]) VALUES (2, N'Ahmed',1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel',3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman',4,  N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez',2, N'03036061000', N'Lahore')
GO

INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'6569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'3336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'6566')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'3436')
GO

INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (1, N'Withdraw')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (2, N'Deposit')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (3, N'Scheduled')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (4, N'Failed')
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'6569', 500,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'3436', 3000,3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'6566', 2500,2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'6566', 2000,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'3336', 6000,4)
GO

Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType

-------------------------------------
create procedure dbo.[Name]      --1
(
	@input_username varchar(20) 
)
as
begin
	select *
	from [User]
	where 
	[name]=@input_username
end
execute dbo.[Name] @input_username='Ali';
---------------------------------------
create procedure dbo.mini_bal    --2
(
	@output_minbal float=0.0 output
)
as
begin
	select @output_minbal=MIN(balance)
	from [Card]
	select @output_minbal as 'Minimum Balance'
end
declare @min_bal FLOAT
execute dbo.mini_bal @output_minbal = @min_bal OUTPUT
select @min_bal AS 'Minimum Balance'

------------------------------------
 create procedure dbo.cardchecker     --3
 (
 @count int output,
 @in_name varchar(20)='',
 @in_id int =0
 )
 as
 begin
	select @count=count(*) 
	from UserCard uc 
	join [User] u on uc.userID=u.userId
	where uc.userID=@in_id and u.[name]=@in_name;
	select @count as CardCount
 end

 declare @output int 
 execute dbo.cardchecker @in_name='Ali',@in_id=1,@count=@output output
 select @output as display
 
 ----------------------------------------
 create procedure dbo.[log-in]  --4
 (
 @in_cardno varchar(20) ,
 @in_pin varchar(4) ,
 @out_status int output
 )
 as 
 begin
	if exists(select * from [Card] where cardNum=@in_cardno and PIN=@in_pin)
		begin
		set @out_status=1;
		end
	else
		begin
		set @out_status=0;
		end
end
declare @status int;
execute dbo.[log-in] @in_cardno='3436',@in_pin='0034',@out_status=@status output    --status 1 checker
--execute dbo.[log-in] @in_cardno='0000',@in_pin='0123',@out_status=@status output   --status 0 checker
select @status as loginstatus
 
select* from [Card];

-----------------------------
create procedure dbo.pin_updater  --5
(
@in_cardno varchar(20),
@in_oldpin varchar(4),
@in_newpin varchar(6),
@result varchar(20) output
)
as 
begin
	if not exists(select * from [Card] where cardNum=@in_cardno and PIN=@in_oldpin)
		begin
			set @result='Error pin does not exists';
			return;
		end
	if len(@in_newpin)>4
		begin 
			set @result='Error pin length is > 4';
			return;
		end
update [Card]
	set PIN=@in_newpin
	where cardNum=@in_cardno and PIN=@in_oldpin
	set @result='PIN Updated successfully';
end

declare @output varchar(20) 
execute dbo.pin_updater @in_cardno='6456',@in_oldpin='1200',@in_newpin='6000',@result=@output output
select @output as [status];

------------------------------------------------
create procedure dbo.withdraw   --6
(
@in_cardno varchar(20) ,
@in_pin varchar(4) ,
@in_trans_amnt float,
@status varchar(20) output
)
as
begin
	declare @logIn_status int
	execute [log-in] @in_cardno,@in_pin ,@logIn_status output;
	if @logIn_status=0
	begin
		set @status='INVLAID card and pin details';
		insert into [Transaction](transId,transDate,cardNum,amount,transType)
		values (((select max(transId) from [Transaction])+1),'2013-04-01',@in_cardno,@in_trans_amnt,4)
		return;
	end
	if not exists(select * from [Card]where balance>@in_trans_amnt and cardNum=@in_cardno and PIN=@in_pin)
	begin
		set @status ='Insufficient amount to transferr';
		insert into [Transaction](transId,transDate,cardNum,amount,transType)
		values (((select max(transId) from [Transaction])+1),'2013-04-01',@in_cardno,@in_trans_amnt,4)
		return;
	end
	begin tran;
	update [Card] 
		set balance=balance-@in_trans_amnt where cardNum=@in_cardno;
		insert into [Transaction](transId,transDate,cardNum,amount,transType)
		values (((select max(transId) from [Transaction])+1),'2013-04-01',@in_cardno,@in_trans_amnt,1)
		commit tran;
		set @status='Withdrawal Successfully';
end

declare @stat varchar(20)
execute dbo.withdraw @in_cardno='6456',@in_pin ='6000',@in_trans_amnt=4325.3,@status=@stat output
select @stat as result                                                                                  --for succeessfull transferr 
																										
select * from [Transaction]																				
																										
select * from[Card]																						
declare @state varchar(20)																				
execute dbo.withdraw @in_cardno='6456',@in_pin ='6000',@in_trans_amnt=12000,@status=@state output		--for insuffieceint transferr
select @state as result																					
select * from [Transaction]																				
																										
declare @sta varchar(20)																				
execute dbo.withdraw @in_cardno='0010',@in_pin ='6000',@in_trans_amnt=12000,@status=@sta output			--for wrong pin or card no
select @sta as result
select *from [Transaction]