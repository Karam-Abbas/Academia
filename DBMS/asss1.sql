
create database abbas
use abbas 
create table Student
(
RollNum nvarchar(20)not null,
Name nvarchar(30)not null,
Gender nvarchar(10) not null,
Phone int not null
)

create table Attendence
(
RollNum nvarchar(20)not null,
Date date not null,
Status char not null,
Classvenue tinyint not null
)

create table ClassVenue
(
ID tinyint not null,
Building nvarchar(10)not null,
RoomNum tinyint not null,
teacher nvarchar(30) not null
)

create table Teacher
(
Name nvarchar(30) not null,
Designation nvarchar(30) not null,
Department nvarchar(30) not null
)

alter table Student add constraint PK_StudentRNo primary key(RollNum);
ALTER TABLE Attendence add constraint PK_Attendence PRIMARY KEY (RollNum, Classvenue, Date);
alter table ClassVenue add constraint PK_iD primary key(ID);
alter table Teacher add constraint PK_teach primary key(Name);

alter table Attendence add constraint FK_StudentRNo foreign key(RollNum) references Student(RollNum) 
on update cascade
on delete no action;
alter table Attendence add constraint FK_attendenceClass foreign key(ClassVenue) references ClassVenue(ID) 
on update cascade
on delete no action;




INSERT INTO Student VALUES
('P16441', 'Ahmad Butt', 'Male', '1234567810'),
('P16443', 'Muhammad Ahmed', 'Male', '1234562789'),
('P16444', 'Ali', 'Male', '1233326789');

INSERT INTO Attendence VALUES 
('P16441', '2023-02-22', 'P', 1),
('P16443', '2023-02-23', 'A', 2),
('P16444', '2023-03-04', 'P', 1);

INSERT INTO ClassVenue VALUES 
(1, 'CS', '2', 'Irtaza'),
(2, 'Electrical', '7', 'Aamir');

INSERT INTO Teacher VALUES 
('Irtaza', 'Lecturer', 'Computer Science'),
('Aamir', 'Assistant Prof.', 'Civil Engineering'),
('Arshad', 'Professor', 'Electrical Engineering');

alter table Student ADD WarningCount int;
alter table Student drop column Phone;

INSERT INTO Student VALUES
('P162334', 'Faizan', 'Male', '1234567810');  --phone number can not be float soo inorder to solve it float was changed with a whole number

INSERT INTO ClassVenue VALUES 
(3, 'CS', '5', 'Ali');

Update Teacher
set Name='Dr.Kashif Zafar' where Name='Kashif';

delete from Student where RollNum='P16443';
delete from Student where RollNum='P16444';

alter table Teacher add constraint un_NAME unique (Name);
truncate table Student;

exec sp_rename 'Teacher','Faculty';

alter table Faculty add Age int;

update Faculty
set Age=35 where Name='Irtaza';
update Faculty
set Age=65 where Name='Aamir';
update Faculty
set Age=40 where Name='Arshad';

select Name,Department from Faculty order by Age asc;
select Name,Department from Faculty order by Age desc;

select * from ClassVenue