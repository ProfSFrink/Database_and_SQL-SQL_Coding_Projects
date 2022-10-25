-- Advanced Software and Web Developer Diploma
-- Course #7 - Database and SQL
-- FINAL PROJECT: Library Management System Project Test queries
--
-- by Steven Partlow

-- Ensure all following statement use database 'db_Library'
USE db_Library
GO

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

SELECT tbl_Book_Loans.CardNo, tbl_Borrower.Name, tbl_Book_Loans.BookID, tbl_Books.Title, tbl_Book_Loans.BranchID, tbl_Library_Branch.BranchName, 
	   tbl_Book_Loans.DateOut, tbl_Book_Loans.DateDue
	FROM tbl_Book_Loans
	INNER JOIN tbl_Borrower ON tbl_Borrower.CardNo = tbl_Book_Loans.CardNo
	INNER JOIN tbl_Library_Branch ON tbl_Library_Branch.BranchID = tbl_Book_Loans.BranchID
	INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_Book_Loans.BookID

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

SELECT *
	FROM tbl_Borrower
	WHERE NOT EXISTS (
		SELECT 1 FROM tbl_Book_Loans
		WHERE CardNo = tbl_Borrower.CardNo
	)