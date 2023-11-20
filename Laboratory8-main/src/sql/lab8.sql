--
--  AMANI SAFARI FRANKLIN
--
-- 
--  lab8.sql
-- Organizational_Chart('title')
-- The purpose of this lab is to gain experience with advanced SQL queries,
-- procedures and functions. Your task is to re-implement your solutions from
-- labs 3 & 6 completely on the database, i.e. no php programming and or data 
-- manipulation. In addition, you will implement one new view.  You will be 
-- evaluated on the quality of your queries.

-- 
-- To execute your script:
--  $> mysql -h 127.0.0.1 -ucmpt310 -p Lab8 < lab8.sql
-- 

DROP PROCEDURE IF EXISTS  Organizational_Chart;
DELIMITER //
CREATE DEFINER = 'cmpt310'@'%' 
PROCEDURE  Organizational_Chart( IN Title VARCHAR(45))

BEGIN
SELECT CONCAT(Technician.Name, "<div class = 'title'>",Technician.Title, "<\div>") AS `Name/Position`, Technician.Technician_EmployeeID AS `Supervisor EmployeeID`, Technician.EmployeeID AS EmployeeID FROM Technician;


END//
DELIMITER ; 



DROP PROCEDURE IF EXISTS Inspections_by_Technician;
DELIMITER //
CREATE DEFINER = 'cmpt310'@'%' 
PROCEDURE Inspections_by_Technician(IN NumInspection INT)
BEGIN 
SELECT Technician.Name,COUNT( Inspection.InspectionID) AS InspectionNumber FROM  Technician, Inspection WHERE Technician.EmployeeID = Inspection.Technician_EmployeeID GROUP BY Name ORDER BY InspectionNumber DESC, Name ASC LIMIT NumInspection;


END//
DELIMITER ; 

DROP PROCEDURE IF EXISTS TPiano_Models_by_Year;
DELIMITER //
CREATE DEFINER = 'cmpt310'@'%' 
PROCEDURE TPiano_Models_by_Year(IN Start INT, IN End INT, IN NumModels INT)
BEGIN 
SELECT Model.Name, Piano.MfgDate, COUNT(Piano.Model_ModelID) As NumberOfPianos FROM Piano, Model WHERE Model.ModelID = Piano.Model_ModelID GROUP BY Piano.MfgDate ORDER BY NumberOfPianos DESC, Name ASC;
END//
DELIMITER ; 


DROP PROCEDURE IF EXISTS Books;
DELIMITER //
CREATE DEFINER = 'cmpt310'@'%' 
PROCEDURE Books()
BEGIN 
SELECT Book.Publisher_ID AS PublisherID, 
    Publisher.Name AS PublisherName, 
    Volume.Series_Book_ISBN AS SeriesISBN, 
    Book.Title As SeriesTitle,
    Volume.Position AS SeriesPosition,
     Authorship.Book_ISBN AS ISBN,
     Book.Title, 
     Book.PublishDate AS PublishDate,
     Author.ID AS AuthorID,
     Author.Name AS AuthorName,
      Author.DateOfBirth, Authorship.RoyaltyPercent, IF(ISNULL(Authorship.LeadAuthor), NULL, IF(Authorship.LeadAuthor = 1, 'Y', 'N')) AS LeadAuthor, Authorship.Position AS AuthorPositon FROM Author      LEFT JOIN Authorship ON Author.ID = Authorship.Author_ID      LEFT JOIN Book ON Book.ISBN = Authorship.Book_ISBN      LEFT JOIN Volume ON  Volume.Volume_Book_ISBN = Book.ISBN      LEFT JOIN Book AS SeriesBook  ON Volume.Series_Book_ISBN = SeriesBook.ISBN      LEFT JOIN Publisher ON Publisher.ID = Book.Publisher_ID UNION SELECT Book.Publisher_ID, 
    Publisher.Name AS PublisherName, 
    Volume.Series_Book_ISBN AS SeriesISBN, 
    Book.Title As SeriesTitle,
    Volume.Position AS SeriesPosition,
     Authorship.Book_ISBN AS ISBN,
     Book.Title, 
     Book.PublishDate AS PublishDate,
     Author.ID AS AuthorID,
     Author.Name AS AuthorName,
      Author.DateOfBirth, Authorship.RoyaltyPercent, IF(ISNULL(Authorship.LeadAuthor), NULL, IF(Authorship.LeadAuthor = 1, 'Y', 'N')) AS LeadAuthor, Authorship.Position AS AuthorPositon FROM Publisher  LEFT JOIN Book ON Book.Publisher_ID = Publisher.ID LEFT JOIN Volume ON Volume.Series_Book_ISBN = Book.ISBN
       LEFT JOIN Book AS SeriesBook ON Volume.Volume_Book_ISBN = SeriesBook.ISBN LEFT JOIN  Authorship ON Book.ISBN = Authorship.Book_ISBN LEFT JOIN Author ON Author.ID = Authorship.Author_ID WHERE Author.ID IS NULL ORDER BY PublisherName;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS TPiano_Models_by_Year;
DELIMITER //
CREATE DEFINER = 'cmpt310'@'%' 
PROCEDURE TPiano_Models_by_Year(IN startYear INT, IN endYear INT, IN n INT)

BEGIN 

   DECLARE i INT DEFAULT startYear;
   
   CREATE TEMPORARY TABLE IF NOT EXISTS TempYear (theYear INT UNIQUE);
   WHILE (i <= endYear) DO
   INSERT IGNORE INTO TempYear VALUES (i);
   SET i = i + 1;
   END WHILE;
   
   SELECT Pianos.Name AS `Name`,
   	  theYear AS `Year`,
   	  COUNT(SerialNo) AS `Number of Pianos` 
   FROM Piano 
   RIGHT OUTER JOIN((SELECT Model.Name, Model.ModelID, COUNT(*) AS NumInspection 
   FROM Piano INNER JOIN Model ON  Piano.Model_ModelID = Model.ModelID 
   GROUP BY Model.ModelID ORDER BY NumInspection DESC LIMIT n)
   AS Pianos CROSS JOIN TempYear ON theYear BETWEEN startYear AND endYear)
   ON Pianos.ModelID = Piano.Model_ModelID AND YEAR(Piano.MfgDate) = theYear
   GROUP BY theYear, Pianos.ModelID
   ORDER BY  NumInspection DESC, Pianos.Name, theYear DESC;
   
   END//
   DELIMITER ; 



DROP PROCEDURE IF EXISTS Authors;
DELIMITER //
CREATE DEFINER = 'cmpt310'@'%' 
PROCEDURE Authors()

BEGIN 

SELECT Author.Name, COUNT(Authorship.Author_ID) AS `Number of Books Published`, IF(COUNT(*)>(SELECT AVG(book_count) FROM (SELECT
COUNT(*) AS book_count FROM Authorship GROUP BY Author_ID) t), '>Average', '<=Average') AS `Productivity`,IF(ISNULL(AVG(RoyaltyPercent)),0.00, TRUNCATE(AVG(Authorship.RoyaltyPercent) ,2)) AS `Average Royalty Rate(%)`, IF(AVG(RoyaltyPercent)> (SELECT AVG(RoyaltyPercent)FROM Authorship), '>Average', '<=Average') AS `Compensation` FROM Author LEFT OUTER JOIN Authorship ON Author.ID = Authorship.Author_ID GROUP BY Author.ID ORDER BY `Number of Books Published`, `Average Royalty Rate(%)` ASC;


END//
DELIMITER ;

