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

/* CREATE DATABASE TABLES (22/10/22) */

--Create 'Publisher' table
CREATE TABLE tbl_Publisher (
	PublisherName NVARCHAR(50) PRIMARY KEY NOT NULL, -- Create field 'PublisherName' which is a fixed 50 character UNICODE string and also the table PRIMARY KEY (NULL VALUES NOT ALLOWED)
	Address NVARCHAR(80) NOT NULL, -- Create field 'Address' which is a fixed 80 character UNICODE string (NULL VALUES NOT ALLOWED)
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
	Address NVARCHAR(80) NOT NULL -- Create field 'Address' which is a fixed 80 character UNICODE string (NULL VALUES NOT ALLOWED)
);

-- Create 'Borrower' table
CREATE TABLE tbl_Borrower (
	CardNo INT PRIMARY KEY NOT NULL IDENTITY (100000, 1), -- Create field 'CardNo' which is an INTEGER and the table PRIMARY KEY which starts at 100000 an increments from there (NULL VALUES NOT ALLOWED)
	Name NVARCHAR(50) NOT NULL, -- Create field 'Name' which is a fixed 50 character UNICODE string (NULL VALUES NOT ALLOWED)
	Address NVARCHAR(80) NOT NULL, -- Create field 'Address' which is a fixed 80 character UNICODE string (NULL VALUES NOT ALLOWED)
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
	DateOut DATE NOT NULL, -- Create field 'DateOut' which is a DATE field (format YYYY-MM-DD) (NULL VALUES NOT ALLOWED)
	DateDue DATE NOT NULL -- Create field 'DateDue' which is a DATE field (format YYYY-MM-DD) (NULL VALUES NOT ALLOWED)
);

/* POPULATE TABLES (22/10/22) */

-- Populate table 'Library Branch' (22/10/22)

INSERT INTO tbl_Library_Branch -- Insert into the table 'tbl_Library_Branch'
	(BranchName, Address) -- into the columns 'BranchName' and 'Address'
	VALUES -- the following values
	('Ipswich', '89 Austin Street, Ipswich, Suffolk, IP28DF'),
	('Mansfield', '21 Argyle Close, Mansfield, Nottinghamshire, NG200JH'),
	('Sharpstown', '44 Prince of Wales Drive, Sharpstown, Norfolk, NR23TR'),
	('Bramford', 'The Street, Bramford, Ipswich, Suffolk, IP84DU'),
	('Tibshelf', '24 High Street, Tibshelf, Alfreton, DE555NY'),
	('Carlton Colville', '52 Wharfdale Drive, Lowestoft, Suffolk, CL447SZ')
;

-- Populate table 'Borrower' (22/10/22)

INSERT INTO tbl_Borrower -- Insert into the table 'tbl_Borrower'
	(Name, Address, Phone) -- into the colummns 'Name', 'Address' and 'Phone'
	VALUES -- the following values
	('Steven Partlow', '53 Recreation Road, Stowmarket, IP14 1JT', '01449 322101' ),
	('Sophia Mattews', '19 Threadneedle Street, Hadleigh, IP7 5DF', '01473 476875'),
	('Julie Sharman', '40 Lavenham Road, Ipswich, IP2 0LA', '01473 880810'),
	('Lynda Wells', '24 Kingsmead Road, Stowmarket, IP14 1LT', '01449 048485'),
	('Clarke Robus', '293 Colchester Road, Ipswich, IP4 4SG', '01473 114554'),
	('Ciara Caldwell', '2 Commerce Street, Sharpstown, ST3 1NH', '01782 626578'),
	('Lesley Lea', '72 Peveril Road, Tibshelf, DE55 5LR', '01623 837621'),
	('Gemma Bradford', '17 Redcliffe Road, Mansfield, NG18 2QH', '01623 104421'),
	('Albert Fairfield', '3 Lingfield Close, Mansfield, NG18 3LW', '01623 727001'),
	('Samantha Lea', '27 Pockthorpe Gate, Lowestoft, NR3 1TU,', '01603 368836'),
	('Damien Johnson', '86 Youlgreave Avenue, Stowbridge, CO2 9LF', '01782 183724'),
	('Tracy Moore', '307 Wroxham Road, Lowestoft, NR7 8RN', '01603 367872')
;

-- Populate table 'Publisher' (22/10/22)

INSERT INTO tbl_Publisher -- Insert into the table 'tbl_Publilsher'
	(PublisherName, Address, Phone) -- into the colummns 'PublisherName', 'Address' and 'Phone'
	VALUES -- the following values
	('Penguin Random House', '2D Greenwich South Street, London, SE10 8TY', '020 2481 3830'),
	('Hachette Livre', '61 The Vista, London, SE9 5RE', '01689 353111'),
	('HarperCollins', '64 Jasper Road, London, SE19 1SQ', '020 2458 1251'),
	('Titan Books', '51A Station Approach, South Ruislip, HA4 6SL', '01895 004525'),
	('Oxford University Press', '59 - 61 Cornmarket Street, Oxford, OX1 3HB', '01865 745273'),
	('Black Library', '4 Phoenix Place, Nottingham, NG8 6BA', '0115 051 4275'),
	('Simon & Schuster', '5 Churchfields Avenue, Weybridge, KT13 9YA', '01932 013008'),
	('Bloomsbury', '219 Hamilton Drive West, York, YO24 4PL', '01904 136533'),
	('John Wiley & Sons', 'Glasfryn, Cynwyd, LL21 0LT', '01490 244813'),
	('Tor - Forge', '43 Roundthorn Road, Manchester, M23 1FL', '0161 205 2031'),
	('CreateSpace Independent Publishing' , '2856 Camden Place, Mount Pleasant, 29464', '843-849-6244')
;

-- Populate table 'Books' (23/10/22)

INSERT INTO tbl_Books -- Insert into the table 'tbl_Books'
	(Title, PublisherName) -- into the colummns 'Title' and 'PublisherName'
	VALUES -- the following values
	/* 1001 */('Fire & Blood', 'Penguin Random House'),
	/* 1002 */('Shadow Reel', 'Penguin Random House'),
	/* 1003 */('Comedy Comedy Comedy', 'Penguin Random House'),
	/* 1004 */('Eisenhorn', 'Black Library'),
	/* 1005 */('The Wraithbone Phoenix', 'Black Library'),
	/* 1006 */('Echoes of Eternity', 'Black Library'),
	/* 1007 */('First and Only', 'Black Library'),
	/* 1008 */('On the Origin of the Species', 'Hachette Livre'),
	/* 1009 */('The Famous Five', 'Hachette Livre'),
	/* 1010 */('The Lost Tribe', 'HarperCollins'),
	/* 1011 */('The Lord of the Rings', 'HarperCollins'),
	/* 1012 */('Descendant Machine', 'Titan Books'),
	/* 1013 */('Stars and Bones', 'Titan Books'),
	/* 1014 */('Light of Impossible Stars', 'Titan Books'),
	/* 1015 */('Seven Myths of the Spanish Conquest', 'Oxford University Press'),
	/* 1016 */('The Code Breaker', 'Simon & Schuster'),
	/* 1017 */('The White Queen', 'Simon & Schuster'),
	/* 1018 */('Database Systems', 'Bloomsbury'),
	/* 1019 */('Introduction to Modeling and Simulation', 'John Wiley & Sons'),
	/* 1020 */('Software Architect', 'John Wiley & Sons'),
	/* 1021 */('The Third Instinct', 'Tor - Forge'),
	/* 1022 */('The Hobbit', 'HarperCollins'),
	/* 1023 */('The Silmarillion', 'HarperCollins'),
	/* 1024 */('Sega Arcade Classics Vol. 1', 'CreateSpace Independent Publishing'),
	/* 1025 */('Sega Arcade Classics Vol. 2', 'CreateSpace Independent Publishing'),
	/* 1026 */('Data East Arcade Classics', 'CreateSpace Independent Publishing'),
	/* 1027 */('Horus Rising', 'Black Library'),
	/* 1028 */('Day of Ascension', 'Black Library'),
	/* 1029 */('Sigismund - The Eternal Crusader', 'Black Library'),
	/* 1030 */('Tinker Taylor Soldier Spy', 'Penguin Random House')
;

-- Populate table 'Book Authors' (23/10/22)

INSERT INTO tbl_Book_Authors -- Insert into the table 'Book Authors'
	(BookID, AuthorName) -- into the colummns 'AuthorName'
	VALUES -- the following values
	(1001, 'George RR Martin'),
	(1002, 'C J Box'),
	(1003, 'Bob Odenkirk'),
	(1004, 'Dan Abnett'),
	(1005, 'Alec Worley'),
	(1006, 'Aaron Demski Bowden'),
	(1007, 'Dan Abnett'),
	(1008, 'Charles Darwin'),
	(1009, 'Enid Blyton'),
	(1010, 'Erik Gross'),
	(1011, 'J RR Tolkien'),
	(1012, 'Gareth L Powell'),
	(1013, 'Gareth L Powell'),
	(1014, 'Gareth L Powell'),
	(1015, 'Matthew Restall'),
	(1016, 'Walter Isaacson'),
	(1017, 'Philippa Gregory'),
	(1018, 'Paul Beynon-Davies'),
	(1019, 'Mark W Spong'),
	(1020, 'Micheal Bell'),
	(1021, 'Kent Lester'),
	(1022, 'J RR Tolkien'),
	(1023, 'J RR Tolkien'),
	(1024, 'Kurt Kalata'),
	(1025, 'Kurt Kalata'),
	(1026, 'Kurt Kalata'),
	(1027, 'Dan Abnett'),
	(1028, 'Adrian Tchaikovsky'),
	(1029, 'John French'),
	(1030, 'John Le Carre')
;

-- Populate table 'Book Copies' (23/10/22)

INSERT INTO tbl_Book_Copies -- Insert into the table 'tbl_Book_Copies'
	(BookID, BranchID, Number_of_Copies) -- into the colummns 'BookID', 'BranchID' and 'Number of Copies'
	VALUES -- the following values
	('1011', '1', '10'),
	('1004', '1', '3'),
	('1030', '1', '8'),
	('1025', '1', '2'),
	('1015', '1', '6'),
	('1001', '2', '5'),
	('1008', '2', '12'),
	('1022', '2', '6'),
	('1002', '2', '3'),
	('1026', '2', '4'),
	('1010', '3', '5'),
	('1021', '3', '4'),
	('1017', '3', '2'),
	('1024', '3', '5'),
	('1005', '3', '7'),
	('1013', '4', '3'),
	('1018', '4', '2'),
	('1016', '4', '4'),
	('1002', '5', '9'),
	('1011', '5', '6'),
	('1003', '5', '2'),
	('1021', '5', '2'),
	('1007', '6', '6'),
	('1011', '6', '5'),
	('1019', '6', '2')
;

-- Populate table 'Book Loans' (/10/22)

INSERT INTO tbl_Book_Loans -- Insert into the table 'tbl_Book_Loans'
	(BookID, BranchID, CardNo, DateOut, DateDue) -- into the colummns 'BookID', 'BranchID', 'CardNo', 'DateOut', and 'DateDue'
	VALUES -- the following values
	(1004, 1, 100000, '2022-10-21', '2022-10-28'),
	(1001, 2, 100007, '2022-10-22', '2022-10-29'),
	(1011, 6, 100009, '2022-10-26', '2022-11-02'),
	(1010, 3, 100005, '2022-10-24', '2022-10-31'),
	(1005, 3, 100008, '2022-10-29', '2022-11-06'),
	(1013, 4, 100010, '2022-10-22', '2022-10-29'),
	(1016, 4, 100010, '2022-10-22', '2022-10-29'),
	(1003, 5, 100006, '2022-10-19', '2022-10-27'),
	(1007, 5, 100011, '2022-10-03', '2022-10-11'),
	(1030, 1, 100001, '2022-10-23', '2022-01-30')
;

/* TEST QUERIES TO ENSURE DATA IS IN THE TABLES CORRECTLY */

SELECT * 
	FROM tbl_Library_Branch

SELECT *
	FROM tbl_Book_Copies

SELECT *
	FROM tbl_Books

SELECT *
	FROM tbl_Book_Authors

SELECT * 
	FROM tbl_Borrower

SELECT *
	FROM tbl_Book_Loans

SELECT *
	FROM tbl_Publisher

SELECT tbl_Books.BookID AS 'Book ID:', tbl_Books.Title AS 'Book Title:', tbl_Book_Authors.AuthorName AS 'Author Name:', tbl_Books.PublisherName AS 'Publisher Name:',
	   tbl_Library_Branch.BranchID AS 'Branch ID:', tbl_Library_Branch.BranchName AS 'Branch Name:', tbl_Book_Copies.Number_of_Copies AS 'Number of Book Copies:'
	FROM tbl_Book_Copies
	INNER JOIN tbl_Library_Branch ON tbl_Library_Branch.BranchID = tbl_Book_Copies.BranchID
	INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_Book_Copies.BookID
	INNER JOIN tbl_Book_Authors ON tbl_Book_Authors.BookID = tbl_Books.BookID
	ORDER BY tbl_Books.BookID

SELECT *
	FROM ((tbl_Book_Loans 
	FULL OUTER JOIN tbl_Borrower ON tbl_Book_Loans.CardNo = tbl_Borrower.CardNo) 
	FULL OUTER JOIN tbl_Books ON tbl_Book_Loans.BookID = tbl_Books.BookID)
	ORDER BY BranchID DESC;