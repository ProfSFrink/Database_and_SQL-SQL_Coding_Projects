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
	('1010', '5', '2'),
	('1010', '6', '7'),
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

-- Populate table 'Book Loans' (23/10/22)

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

/* Example QUERY to show how each of the tables RELATE to each other (23/10/22) */

SELECT * -- SELECT ALL COLUMNS from the following tables
	FROM ((tbl_Book_Loans -- 
	/* Then starting with 'tbl_Book_Loans' SELECT all rows that match the following OUTER JOINS */ 
	/* FULL OUTER JOIN the column 'CardNo' between the tables 'tbl_Book_Loans' and 'tbl_Borrower' */
	FULL OUTER JOIN tbl_Borrower ON tbl_Book_Loans.CardNo = tbl_Borrower.CardNo) 
	/* FULL OUTER JOIN the column 'BookID' between the tables 'tbl_Book_Loans' and 'tbl_Books' */
	FULL OUTER JOIN tbl_Books ON tbl_Book_Loans.BookID = tbl_Books.BookID)
	/* Order result by 'BranchID' in DESCENDING order */
	ORDER BY BranchID DESC;

/* Using the library database we created write a QUERY that returns all book titles and the authors name (24/10/22) */

/* SELECT the columns 'BookID' with ALIAS 'Book ID', 'Title' with ALIAS 'Book Title' and 'PublisherName' with ALIAS 'Publisher Name:' from 'tbl_Books' and 'AuthorName' 
   with ALIAS 'Author Name:' from 'tbl_Book_Authors'  */
SELECT tbl_Books.BookID AS 'Book ID:', tbl_Books.Title AS 'Book Title:', tbl_Book_Authors.AuthorName AS 'Author Name:', tbl_Books.PublisherName AS 'Publisher Name:'
	FROM tbl_Books
	/* Then starting with 'tbl_Books' SELECT all rows listed above that match the following INNER JOIN */
	/* INNER JOIN the column 'BookID' between the tables 'tbl_Book_Authors' and 'tbl_Books' */
	INNER JOIN tbl_Book_Authors ON tbl_Book_Authors.BookID = tbl_Books.BookID

/* STORED PROCEDURES */

/* STORED PROCEDURE A) How many copies of the book title 'The Lost Tribe' are owned by the library branch whose name is 'Sharpstown'? (25/10/22) */

CREATE PROCEDURE dbo.Copies_Owned_Indvidual_Branch @Branch_Name NVARCHAR(30), @Book_Title NVARCHAR(30)
AS
BEGIN /* START PROCEDURE */

	DECLARE @errorString VARCHAR(100) -- Declare a 100 fixed-character length string called '@errorString'

	DECLARE @resultsBranchCheck AS VARCHAR(5) -- Declare a 5 fixed-character length string called '@resultsBranchCheck'
	DECLARE @resultsBookCheck AS VARCHAR(5) -- Declare a 5 fixed-character length strings called'@resultsBookCheck'

	/* The purpose of the TRY BLOCK is to check if both the branch name entered and the book name entered exists in the system */

	BEGIN TRY -- Start of TRY BLOCK

		/* COUNT how many rows appear in 'tbl_Library_Branch' that have the 'BranchID' of the branch we are looking for and SET
			'resultsBranchCheck' to the result */
		SET @resultsBranchCheck = (SELECT COUNT(tbl_Library_Branch.BranchName) 
			FROM tbl_Library_Branch 
			WHERE BranchName = @Branch_Name)

		/* COUNT how many rows appear in 'tbl_Books' that have the '@Book_Title' of the book we are looking for and SET
			'resultsBookCheck' to the result */
		SET @resultsBookCheck = (SELECT COUNT(tbl_Books.Title) 
			FROM tbl_Book_Copies 
			INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_Book_Copies.BookID
			WHERE tbl_Books.Title = @Book_Title)

		/* IF the branch entered DOES NOT exist in the system  we generate our error string and raise an error */

		IF @resultsBranchCheck = 0
			BEGIN
				SET @errorString = 'There are no branches named ' + @Branch_Name + ' found!' -- Concatenate '@Branch_Name' into this error string
				RAISERROR(@errorString, 16, 1) -- We throw an error as that branch does not exist in the database
				RETURN
			END -- END IF

		/* IF the branch entered DOES exist BUT the book entered DOES NOT exist in the system  we generate our error string and raise an error */

		ELSE IF @resultsBookCheck = 0 -- Then IF we have no rows with book name
			BEGIN
				SET @errorString = 'There are no copies of the book named ' + @Book_Title + ' available in any of our branches!' -- Concatenate '@Book_Title' into this error string
				RAISERROR(@errorString, 16, 1) -- We throw an error as there are no copies of that book checked out
			END -- END IF

		/*  IF BOTH the branch and book exist then we execute our query */

		ELSE IF (@resultsBranchCheck >= 1) AND (@resultsBookCheck >= 1)
			BEGIN
				/* We give the tables in this QUERY the following ALIASES
					tbl_Book_Copies = Copies
					tbl_Library_Branch = Branches
					tbl_Books = Books
					tbl_Book_Authors = Authors 
					We also give our COLUMNS ALIASES */
				/* SELECT COLUMNS 'BookID', 'BookTitle', 'AuthorName', 'PublisherName', 'BranchID', 'BranchName' and 'Number_of_Copies'*/
				SELECT Copies.BookID AS 'Book ID:', Books.Title AS 'Book Title:', Authors.AuthorName AS 'Author Name:', Books.PublisherName AS 'Publisher Name:',
					Branches.BranchID AS 'Branch ID:', Branches.BranchName AS 'Branch Name:', Copies.Number_of_Copies AS 'Number of Copies:'  

				/*  Start FROM 'tbl_Book_Copies we OUTER JOIN with FOUR tables'*/
				FROM tbl_Book_Copies AS Copies 
					/* OUTER JOIN the Library Branch and Book Copies tables through the BranchID column */
					FULL OUTER JOIN tbl_Library_Branch AS Branches ON Copies.BranchID = Branches.BranchID
					/* OUTER JOIN the Books and Book Copies tables through the BookID column */
					FULL OUTER JOIN tbl_Books AS Books ON Copies.BookID = Books.BookID
					/* OUTER JOIN the Book AUthors and Book tables through the BookID column */
					FULL OUTER JOIN tbl_Book_Authors AS Authors ON Books.BookID = Authors.BookID
					/* ONLY SELECT COLUMNS that have the matching Book title and Branch name */
					WHERE Books.Title = @Book_Title AND Branches.BranchName = @Branch_Name;
			END -- END IF
	END TRY -- END of TRY BLOCK

	BEGIN CATCH -- Start of CATCH BLOCK
		SELECT @errorString = ERROR_MESSAGE() -- Use the built-in 'ERROR_MESSAGE' function and pass in out 'errorString' string
		RAISERROR (@errorString, 10, 1)
	END CATCH -- End of CATCH BLOCK

END /* END OF PROCEDURE */

-- EXECUTE STORED PROCEDURE and pass in two arguements 'Branch Name' and 'Book Name'

[dbo].[Copies_Owned_Indvidual_Branch] 'Sharpstown', 'The Lost Tribe';

/* STORED PROCEDURE B) How many copies of the book titled "The Lost Tribe" are by each library branch? (25/10/2022) */

CREATE PROCEDURE dbo.Copies_Owned_Each_Branch @Book_Title NVARCHAR(30)
AS
BEGIN /* START PROCEDURE */

	DECLARE @errorString VARCHAR(100) -- Declare a 100 fixed-character length string called '@errorString'
	DECLARE @resultsBookCheck AS VARCHAR(5) -- Declare a 5 fixed-character length strings called'@resultsBookCheck'

	/* The purpose of the TRY BLOCK is to check if both the book name entered exists in the system */

	BEGIN TRY -- Start of TRY BLOCK

		/* COUNT how many rows appear in 'tbl_Books' that have the '@Book_Title' of the book we are looking for and SET
			'resultsBookCheck' to the result */
		SET @resultsBookCheck = (SELECT COUNT(tbl_Books.Title) 
			FROM tbl_Book_Copies 
			INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_Book_Copies.BookID
			WHERE tbl_Books.Title = @Book_Title)

		/* IF the book entered DOES NOT exist in the system  we generate an error string and raise an error */

		IF @resultsBookCheck = 0 -- Then IF we have no rows with book name
			BEGIN
				SET @errorString = 'There are no copies of the book named ' + @Book_Title + ' available in any of our branches!' -- Concatenate '@Book_Title' into this error string
				RAISERROR(@errorString, 16, 1) -- We throw an error as there are no copies of that book checked out
			END -- END IF

		/*  IF the book exists then we execute our query */

		ELSE IF @resultsBookCheck >= 1
			BEGIN
				 /* We give the tables in this QUERY the following ALIASES
					tbl_Book_Copies = Copies
					tbl_Library_Branch = Branches
					tbl_Books = Books
					We also give our COLUMNS ALIASES */
				/* SELECT COLUMNS 'BookID', 'BookTitle', 'PublisherName', 'BranchID', 'BranchName', 'Address' and 'Number_of_Copies'*/
				SELECT Books.BookID AS 'Book ID:', Books.Title AS 'Book Title:', Books.PublisherName AS 'Publisher Name:', 
					   Branches.BranchID AS 'Branch ID:', Branches.BranchName AS 'Branch Name:', Branches.Address AS 'Branch Address:', Copies.Number_of_Copies AS 'Number of Book Copies:'
				FROM ((tbl_Book_Copies AS Copies
					/* OUTER JOIN the Library Branch and Book Copies tables through the BranchID column */
					FULL OUTER JOIN tbl_Library_Branch AS Branches ON Branches.BranchID = Copies.BranchID)
					/* OUTER JOIN the Books and Book Copies tables through the BookID column */
					FULL OUTER JOIN tbl_Books AS Books ON Books.BookID = Copies.BookID)
					/* ONLY SELECT COLUMNS that have the matching Book title */
					WHERE Books.Title = @Book_Title;

			END -- END IF
	END TRY -- END of TRY BLOCK

	BEGIN CATCH -- Start of CATCH BLOCK
		SELECT @errorString = ERROR_MESSAGE() -- Use the built-in 'ERROR_MESSAGE' function and pass in out 'errorString' string
		RAISERROR (@errorString, 10, 1)
	END CATCH -- End of CATCH BLOCK

END /* END OF PROCEDURE */

-- EXECUTE STORED PROCEDURE and pass in a single arguement 'Book Name'

[dbo].[Copies_Owned_Each_Branch] 'The Lost Tribe'

/* TEST QUERIES TO ENSURE DATA IS IN THE TABLES CORRECTLY */


/* Simple queries to ensure the data has populated each tabel correctly  */

SELECT * -- Query all the content of the table 'tbl_Library_Branch'
	FROM tbl_Library_Branch

SELECT * -- Query all the content of the table 'tbl_Book_Copies'
	FROM tbl_Book_Copies

SELECT * -- Query all the content of the table 'tbl_Books'
	FROM tbl_Books

SELECT * -- Query all the content of the table 'tbl_Book_Authors'
	FROM tbl_Book_Authors

SELECT * -- Query all the content of the table 'tbl_Borrower'
	FROM tbl_Borrower

SELECT * -- Query all the content of the table 'tbl_Book_Loans'
	FROM tbl_Book_Loans

SELECT * -- Query all the content of the table 'tbl_Publisher'
	FROM tbl_Publisher

/* List all books in the tale 'Book Copies' then utilizing INNER JOINS accquire the book title and author from the 'Books' table then the publisher name from the
	'Publisher' table then see how many copies of each book in branch has */

/* SELECT 'BookID', 'Title' and 'PublihserName' from the books table, the 'AuthorName' from the book author table, the 'BranchID' and 'BranchName' from the library branch table
   then finally the 'number_of_copies' of the book from the book copies table */
SELECT tbl_Books.BookID AS 'Book ID:', tbl_Books.Title AS 'Book Title:', tbl_Book_Authors.AuthorName AS 'Author Name:', tbl_Books.PublisherName AS 'Publisher Name:',
	   tbl_Library_Branch.BranchID AS 'Branch ID:', tbl_Library_Branch.BranchName AS 'Branch Name:', tbl_Book_Copies.Number_of_Copies AS 'Number of Book Copies:'
	FROM tbl_Book_Copies
	/* Then starting with 'tbl_Book_Copies' SELECT all rows that match the following JOINS */ 
	/* INNER JOIN the column 'BranchID' between the tables 'tbl_Library_Branch' and 'tbl_Book_Copies' */
	INNER JOIN tbl_Library_Branch ON tbl_Library_Branch.BranchID = tbl_Book_Copies.BranchID
	/* INNER JOIN the column 'BookID' between the tables 'tbl_Books' and 'tbl_Book_Copies' */
	INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_Book_Copies.BookID
	/* INNER JOIN the column 'BookID' between the tables 'tbl_Book_Authors' and 'tbl_Book_Copies' */
	INNER JOIN tbl_Book_Authors ON tbl_Book_Authors.BookID = tbl_Books.BookID
	/* Sort all the result in ascending order by 'BookID' */
	ORDER BY tbl_Books.Title

DECLARE @errorStringBranch VARCHAR(100) -- Declare a 100 fixed-character length string called '@errorStringBranch'
DECLARE @errorStringBook VARCHAR(100) -- Declare a 100 fixed-character length string called '@errorStringBook'
DECLARE @resultsBranchCheck AS VARCHAR(5) -- Declare a 5 fixed-character length string called '@resultsBranchCheck'
DECLARE @resultsBookCheck AS VARCHAR(5) -- Declare a 5 fixed-character length strings called'@resultsBookCheck'

SET @errorStringBranch = 'There are no branches named Sharpstown found!' -- Concatenate '@Book_Title' and '@Branch_Name' into this error string
SET @errorStringBook = 'There are no copies of the book named The Lost Tribe in any of our branches'

/* COUNT how many rows appear in 'tbl_Library_Branch' that have the 'BranchID' of the branch we are looking for and SET
	'resultsBranchCheck' to the result */
SET @resultsBranchCheck = (SELECT COUNT(tbl_Library_Branch.BranchName) 
	FROM tbl_Library_Branch 
	WHERE BranchName = 'Sharpstown')

/* COUNT how many rows appear in 'tbl_Book_Copies' that have the 'BookID' of the book we are looking for and SET
	'resultsBookCheck' to the result */
SET @resultsBookCheck = (SELECT COUNT(tbl_Books.Title) 
	FROM tbl_Book_Copies 
	INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_Book_Copies.BookID
	WHERE tbl_Books.Title = 'The Lost Tribe')

PRINT(@resultsBranchCheck)
PRINT(@resultsBookCheck)
PRINT(@errorStringBranch)
PRINT(@errorStringBook)

SELECT Books.BookID AS 'Book ID:', Books.Title AS 'Book Title:', Books.PublisherName AS 'Publisher Name:', 
	   Branches.BranchID AS 'Branch ID:', Branches.BranchName AS 'Branch Name:', Branches.Address AS 'Branch Address:', Copies.Number_of_Copies AS 'Number of Book Copies:'
FROM ((tbl_Book_Copies AS Copies
	FULL OUTER JOIN tbl_Library_Branch AS Branches ON Branches.BranchID = Copies.BranchID)
	FULL OUTER JOIN tbl_Books AS Books ON Books.BookID = Copies.BookID)
	WHERE Books.Title = 'The Lost Tribe';