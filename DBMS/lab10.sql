create database lab10
use lab10
create table Students
(RollNo varchar(7) primary key
,Name varchar(30)
,WarningCount int
,Department varchar(15)
)
GO
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'1', N'Ali', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'2', N'Bilal', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'3', N'Ayesha', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'4', N'Ahmed', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'5', N'Sara', 0, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'6', N'Salman', 1, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'7', N'Zainab', 2, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'8', N'Danial', 1, N'CS')

go
create table Courses
(
CourseID int primary key,
CourseName varchar(40),
PrerequiteCourseID int,
CreditHours int
) 
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (10, N'Database Systems', 20, 3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (20, N'Data Structures', 30,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (30, N'Programing', NULL,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (40, N'Basic Electronics', NULL,3)
go

go
Create table Instructors 
(
InstructorID int Primary key,
Name varchar(30),
Department varchar(7) ,
)
GO
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (100, N'Ishaq Raza', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (200, N'Zareen Alamgir', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (300, N'Saima Zafar', N'EE')
go
Create table Semester
(
Semester varchar(15) Primary key,
[Status] varchar(10),
)
GO
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Fall2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2017', N'InProgress')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Summer2016', N'Cancelled')
go
Create table Courses_Semester
(
InstructorID int Foreign key References Instructors(InstructorID),
CourseID int Foreign key References Courses(CourseID),
Semester varchar(15) Foreign key References Semester(Semester), 
Section varchar(1) ,
AvailableSeats int,
Department varchar(2)
)
GO
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'D', 45, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'C', 0, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (100, 10, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2016', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2016', N'A', 0, N'CS')

go



create table Registration
(
Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Students(RollNo),
CourseID int Foreign key References Courses(CourseID), 
Section varchar(1),
GPA float
)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'1', 20, N'A', 3.3)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'2', 20, N'B', 4)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2016', N'1', 30, N'A', 1.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'6', 40, N'D',0.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2017', N'6', 40, N'D',1)


go

Create table ChallanForm
(Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Students(RollNo),
TotalDues int,
[Status] varchar(10)
)
GO
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'1', 100000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'2', 13333, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'3', 5000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'4', 20000, N'Pending')


select * from Students
select * from Courses
select * from Instructors
select * from Registration
select * from Semester
select * from Courses_Semester
select * from ChallanForm
------Function 1----
create trigger del_student 
On Students
instead of delete
AS Begin
PRINT 'you can not delete this data'
END
GO
----Function 2-----
create trigger ins_course on Courses
after insert
as begin
print 'You can not insert data into table'
END
------Funtion 3-----
create Table Notify (
NotificationID int IDENTITY(1,1) Not NULL primary key,
StudentId VARCHAR(7),
notification_string nvarchar(255)
)

CREATE TRIGGER registration_notification
ON Registration
AFTER INSERT
AS
BEGIN
DECLARE @passed_prerequisite BIT;
DECLARE @seats_available BIT;
DECLARE @notification_text VARCHAR(255);
DECLARE @student_id INT;
SELECT @student_id = Registration.RollNumber from Registration
SELECT @passed_prerequisite = Courses.PrerequiteCourseID FROM Students, Courses  WHERE Students.RollNo = @student_id;
SELECT @seats_available = c.AvailableSeats FROM Courses_Semester c WHERE c.CourseID = (SELECT inserted.CourseID FROM inserted);
IF @passed_prerequisite = 1 AND @seats_available = 1
    SET @notification_text = CONCAT('Your registration for course ', (SELECT inserted.CourseID FROM inserted), ' was successful.');
ELSE
    SET @notification_text = CONCAT('Your registration for course ', (SELECT inserted.CourseID FROM inserted), ' was not successful.');

INSERT INTO Notify ([NotificationID],[StudentId] ,[notification_string])
VALUES (COUNT_BIG(*)+1,@student_id, @notification_text);
END
------ Function 4-----
CREATE TRIGGER check_fee_charges
ON Courses_Semester
INSTEAD OF INSERT
AS
BEGIN
  IF EXISTS (
    SELECT 1
    FROM Students i
    WHERE i.WarningCount > 0
  )
  BEGIN
    PRINT 'Cannot enroll student with warning count greater than 0.'
  END
  ELSE IF EXISTS (
    SELECT 1
    FROM Students i
    left JOIN ChallanForm s ON i.RollNo = s.RollNumber
    WHERE s.TotalDues > 20000
  )
  BEGIN
    PRINT 'Cannot enroll student with more than 20,000 fee charges due.'
  END
  ELSE
  BEGIN
    INSERT INTO Courses_Semester (InstructorID, CourseID, Semester, Section, AvailableSeats, Department)
    SELECT InstructorID, CourseID, Semester, Section, AvailableSeats, Department
    FROM inserted
  END
END
------Function 5 ------
CREATE TRIGGER trg_delete_course_semester
ON Courses_Semester
FOR DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE AvailableSeats < 10)
    BEGIN
        PRINT 'not possible'
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        PRINT 'Successfully deleted'
    END
END
------Function 6----
CREATE TRIGGER tr_InstructorsModification
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    DECLARE @EventData XML = EVENTDATA()
    DECLARE @ObjectName NVARCHAR(255)
    SET @ObjectName = @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)')
    IF @ObjectName = 'Instructors'
    BEGIN
        RAISERROR('Cannot modify or drop Instructors table.', 16, 1)
        ROLLBACK
    END
END;


