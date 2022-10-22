-- Advanced Software and Web Developer Diploma
-- Course #7 - Database and SQL
-- FINAL PROJECT: Library Management System Project
--
-- by Steven Partlow

-- Create a new database called 'db_library'
CREATE DATABASE db_Library

-- Ensure all following statement use database 'db_Library'
USE db_Library
GO

--Create 'Publisher' table
CREATE TABLE tbl_Publisher (
	PublisherName NVARCHAR(50) PRIMARY KEY NOT NULL, -- Create field 'PublisherName' which is a fixed 50 character UNICODE string and also the table PRIMARY KEY (NULL VALUES NOT ALLOWED)
	Address NVARCHAR(50) NOT NULL, -- Create field 'Address' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
	Phone NVARCHAR(15) NOT NULL -- Create field 'Phone' which is a fixed 15 character UNICODE string (NULL VALUES NOT ALLOWED)
);

-- Create 'Books' table
CREATE TABLE tbl_Books (
	BookID INT PRIMARY KEY NOT NULL IDENTITY (1001, 1), -- Create field 'BookID' which is an INTEGER and also the table PRIMARY KEY which starts at 1001 and increments from there (NULL VALUES NOT ALLOWED)
	Title NVARCHAR(50) NOT NULL, -- Create field 'Address' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)

	/* Create field 'PublisherName' which is a FOREIGN KEY connecting this table to the 'Publisher' table, the field is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED) */
	PublisherName NVARCHAR(50) NOT NULL CONSTRAINT fk_PublisherName FOREIGN KEY REFERENCES tbl_Publisher(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create 'Book Authors' table
CREATE TABLE tbl_Book_Authors (
	/* Create field 'BookID' which is a FOREIGN KEY connecting this table to the 'Books' table, the field is an INTEGER (NULL VALUES NOT ALLOWED) */
	BookID INT NOT NULL CONSTRAINT fk_BookID_Book_Authors FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	AuthorName NVARCHAR(50) NOT NULL -- Create field 'AuthorName' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
);

-- Create 'Library Branch' table
CREATE TABLE tbl_Library_Branch (
	BranchID INT PRIMARY KEY NOT NULL IDENTITY (1, 1), -- Create field 'BranchID' which is an INTEGER and also the table PRIMARY KEY which starts at 1 and increments from there (NULL VALUES NOT ALLOWED)
	BranchName NVARCHAR(50) NOT NULL, -- Create field 'BranchName' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
	Address NVARCHAR(50) NOT NULL -- Create field 'Address' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
);

-- Create 'Borrower' table
CREATE TABLE tbl_Borrower (
	CardNo INT PRIMARY KEY NOT NULL IDENTITY (100000, 1), -- Create field 'CardNo' which is an INTEGER and the table PRIMARY KEY which starts at 100000 an increments from there (NULL VALUES NOT ALLOWED)
	Name NVARCHAR(50) NOT NULL, -- Create field 'Name' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
	Address NVARCHAR(50) NOT NULL, -- Create field 'Address' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
	Phone NVARCHAR(15) NOT NULL -- -- Create field 'Address' which is a fixed 15 character UNICODE string (NULL VALUES NOT ALLOWED)
);

-- Create 'Book Copies' table
CREATE TABLE tbl_Book_Copies (
	/* Create field 'BookID' which is a FOREIGN KEY connecting this table to the 'Books' table, the field is an INTEGER (NULL VALUES NOT ALLOWED) */
	BookID INT NOT NULL CONSTRAINT fk_BookID_Book_Copies FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	/* Create field 'BranchID' which is a FOREIGN KEY connecting this table to the 'Library Branch' table, the field is an INTEGER (NULL VALUES NOT ALLOWED) */
	BranchID INT NOT NULL CONSTRAINT fk_BranchID_Book_Copies FOREIGN KEY REFERENCES tbl_Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	Number_of_Copies INT NOT NULL -- Create field 'Number_of_Copies which is an INTEGER (NULL VALUES NOT ALLOWED)
);

-- Create 'Book Loans' table
CREATE TABLE tbl_Book_Loans (
	/* Create field 'BookID' which is a FOREIGN KEY connecting this table to the 'Books' table, the field is an INTEGER (NULL VALUES NOT ALLOWED) */
	BookID INT NOT NULL CONSTRAINT fk_BookID_Book_Loans FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	/* Create field 'BranchID' which is a FOREIGN KEY connecting this table to the 'Library Branch' table, the field is an INTEGER (NULL VALUES NOT ALLOWED) */
	BranchID INT NOT NULL CONSTRAINT fk_BranchID_Book_Loans FOREIGN KEY REFERENCES tbl_Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	/* Create field 'CardNo' which is a FOREIGN KEY connecting this table to the 'Borrower' table, the field in an INTEGER (NULL VALUES NOT ALLOWED) */
	CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES tbl_Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	DateOut DATE, -- Create field 'DateOut' which is a DATE field (format YYYY-MM-DD) (NULL VALUES NOT ALLOWED)
	DateDue DATE -- Create field 'DateDue' which is a DATE field (format YYYY-MM-DD) (NULL VALUES NOT ALLOWED)
);