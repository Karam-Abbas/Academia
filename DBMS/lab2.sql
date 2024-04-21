use aliens
create table Students
(
Student_ID nvarchar(15) not null,
Student_Name nvarchar(50),
Student_Address nvarchar(50),
Student_Batch int,
Department nvarchar(10)
)
create table Instructors
(
Instructor_ID nvarchar(15) not null,
Instructor_Name nvarchar(50),
Salary int,
Joining_date date
)
create table Courses
(
Course_ID nvarchar(50) not null,
Course_Name nvarchar(20),
CourseCreditHours int,
Instructor_ID nvarchar(15)
)
create table Registration
(
Student_ID nvarchar(15) ,
Course_ID nvarchar(50),
Grade nvarchar(2)
)

alter table Students add constraint PK_STUDENT primary key(Student_ID)
alter table Registration add constraint FK_STUDENT foreign key (Student_ID) references Students(Student_ID)

alter table Instructors add constraint PK_Instructor primary key(Instructor_ID)
alter table Courses add constraint FK_Instructor foreign key (Instructor_ID) references Instructors(Instructor_ID)

alter table Courses add constraint PK_COURSE primary key(Course_ID)
alter table Registration add constraint FK_Course foreign key (Course_ID) references Courses(Course_ID)

insert into Students 
values
(1,'Ali Raza Awan','123 model town,peshawar',2019,'CS'),
(2,'Ayesha Khan','567 FASISAL TOWN ,KARACHI',2018,'DS'),
(3,'ch Ahmad Mughal','890 GAJUMATA,LAHORE',2020,'EE')

insert into Instructors
values
(1,'Ali Raza Awan',8900,'2011-01-12')

insert into Courses
values
(1,'compoter prooooo',3,1)

insert into Registration
values
(1,1,'A')

select Student_ID,Student_Batch from Students

select * from Students where (Department='DS')

select *from Instructors where Instructor_Name like'%Ali%'

insert into Instructors
values
(2,'Raza',9900,'2016-06-14')

select *from Instructors 
order by Salary desc

select *from Instructors where (Joining_date<'2018-01-01')

select*from Instructors where MONTH(Joining_date)=01 OR MONTH(Joining_date)=12

SELECT Instructor_Name,salary+5000 from Instructors 

exec sp_rename 'dbo.Courses.Course_Name','Subject_Name','COLUMN';
SELECT*FROM Courses 