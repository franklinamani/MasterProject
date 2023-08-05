DROP TABLE IF EXISTS `Volume`, `Authorship`, `Author`, `Book`, `Publisher`;

CREATE TABLE `Author` (
  `ID`                NUMERIC(13)           NOT NULL,
  `Name`              VARCHAR(255)          NOT NULL,
  `DateOfBirth`       DATE                  NOT NULL,

  CONSTRAINT `Author_PK` PRIMARY KEY (`ID`)
);

CREATE TABLE `Publisher` (
  `ID`                NUMERIC(13)           NOT NULL,
  `Name`              VARCHAR(255)          NOT NULL,

  CONSTRAINT `Publisher_PK` PRIMARY KEY (`ID`)
);

CREATE TABLE `Book` (
  `ISBN`              NUMERIC(13)           NOT NULL,
  `Title`             VARCHAR(255)          NOT NULL,
  `PublishDate`       DATE                  NULL,
  `Publisher_ID`      NUMERIC(13)           NOT NULL,

  CONSTRAINT `Book_PK` PRIMARY KEY (`ISBN`),
  CONSTRAINT `Book_FK` FOREIGN KEY (`Publisher_ID`) REFERENCES `Publisher` (`ID`)
);

CREATE TABLE `Volume` (
  `Series_Book_ISBN`  NUMERIC(13)           NOT NULL,
  `Volume_Book_ISBN`  NUMERIC(13)           NOT NULL,
  `Position`          NUMERIC(2) UNSIGNED   NOT NULL,

  CONSTRAINT `Volume_PK` PRIMARY KEY (`Series_Book_ISBN`, `Volume_Book_ISBN`),
  CONSTRAINT `Volume_FK_Series` FOREIGN KEY (`Series_Book_ISBN`) REFERENCES `Book` (`ISBN`),
  CONSTRAINT `Volume_FK_Volume` FOREIGN KEY (`Volume_Book_ISBN`) REFERENCES `Book` (`ISBN`)
);

CREATE TABLE `Authorship` (
  `Book_ISBN`         NUMERIC(13)           NOT NULL,
  `Author_ID`         NUMERIC(13)           NOT NULL,
  `RoyaltyPercent`    NUMERIC(3,1)          NOT NULL,
  `LeadAuthor`        BOOLEAN               NOT NULL,
  `Position`          NUMERIC(2) UNSIGNED   NOT NULL,

  CONSTRAINT `Authorship_PK` PRIMARY KEY (`Book_ISBN`, `Author_ID`),
  CONSTRAINT `Authorship_FK_Book`   FOREIGN KEY (`Book_ISBN`) REFERENCES `Book`   (`ISBN`),
  CONSTRAINT `Authorship_FK_Author` FOREIGN KEY (`Author_ID`) REFERENCES `Author` (`ID`)
);

INSERT INTO `Author` (`ID`, `Name`, `DateOfBirth`) VALUES
  (1000, 'J. R. R. Tolkien', '1892-01-03'),
  (1001, 'C. S. Lewis', '1898-11-29'),
  (1002, 'Erez Osiris', '1990-01-01'),
  (1003, 'Hed Tighe', '1980-01-01'),
  (1004, 'Jeffery A. Hoffer', '1970-01-01'),
  (1005, 'V. Ramesh', '1971-01-01'),
  (1006, 'Heikki Topi', '1972-01-01'),
  (1007, 'Ramez Elmasri', '1973-01-01'),
  (1008, 'Shamkant B. Navathe', '1974-01-01'),
  (1009, 'Jean Conall', '2000-01-01');


INSERT INTO `Publisher` (`ID`, `Name`) VALUES
  (10000, 'Houghton Mifflin Harcourt'),
  (10001, 'HarperCollins'),
  (10002, 'Pearson'),
  (10003, 'Scribner'),
  (10004, 'A Bookless Publisher');

INSERT INTO `Book` (`ISBN`, `Title`, `PublishDate`, `Publisher_ID`) VALUES
  (9780007525515, 'The Hobbit & The Lord of the Rings', '2007-04-17', 10001),
  (9780012345678, 'A New Series', '2020-01-01', 10000),
  (9780060234812, 'The Lion, the Witch and the Wardrobe', '2007-08-14', 10001),
  (9780060234836, 'Prince Caspian', '2007-08-14', 10001),
  (9780060234867, 'The Voyage of the Dawn Treader', '2007-08-14', 10001),
  (9780060234881, 'The Horse and His Boy', '2007-08-14', 10001),
  (9780060234935, 'The Last Battle', '2007-08-14', 10001),
  (9780060234959, 'The Silver Chair', '2007-08-14', 10001),
  (9780060234973, 'The Magician''s Nephew', '2007-08-14', 10001),
  (9780060244880, 'The Chronicles of Narnia', '2007-08-14', 10001),
  (9780060598242, 'The Chronicles of Narnia', '2004-10-26', 10001),
  (9780133544619, 'Modern Database Management (12th Edition)', '2015-07-13', 10002),
  (9780133970777, 'Fundamentals of Database Systems (7th Edition)', '2015-06-08', 10002),
  (9780261102217, 'The Hobbit', '2007-04-17', 10001),
  (9780261102354, 'The Fellowship of the Ring', '2007-04-17', 10001),
  (9780261102361, 'The Two Towers', '2007-04-17', 10001),
  (9780261102378, 'Return of the King', '2007-04-17', 10001),
  (9780261102385, 'The Lord of the Rings', '2007-04-17', 10001),
  (9780618968633, 'The Hobbit', '2007-09-21', 10000),
  (9780743234900, 'Out of the Silent Planet', '1996-10-01', 10003),
  (9780743234917, 'Perelandra', '1996-10-01', 10003),
  (9780743234924, 'That Hideous Strength', '1996-10-01', 10003),
  (9781451664829, 'The Space Trilogy', '2011-09-20', 10003),
  (9781451612345, 'An Unpublished Authorless Book', NULL, 10003);

INSERT INTO `Authorship` (`Book_ISBN`, `Author_ID`, `RoyaltyPercent`, `LeadAuthor`, `Position`) VALUES
  (9780007525515, 1000, 5.0, TRUE, 1),
  (9780012345678, 1002, 0.0, TRUE, 1),
  (9780060234812, 1001, 15.0, TRUE, 1),
  (9780060234836, 1001, 15.0, TRUE, 1),
  (9780060234867, 1001, 15.0, TRUE, 1),
  (9780060234881, 1001, 15.0, TRUE, 1),
  (9780060234935, 1001, 15.0, TRUE, 1),
  (9780060234959, 1001, 15.0, TRUE, 1),
  (9780060234973, 1001, 15.0, TRUE, 1),
  (9780060244880, 1001, 20.0, TRUE, 1),
  (9780060598242, 1001, 12.0, TRUE, 1),
  (9780133544619, 1004, 10.0, TRUE, 1),
  (9780133544619, 1005, 2.0, FALSE, 2),
  (9780133544619, 1006, 2.0, FALSE, 3),
  (9780133970777, 1007, 5.0, FALSE, 1),
  (9780133970777, 1008, 5.0, TRUE, 2),
  (9780261102217, 1000, 3.0, TRUE, 1),
  (9780261102354, 1000, 1.2, TRUE, 1),
  (9780261102361, 1000, 1.3, TRUE, 1),
  (9780261102378, 1000, 1.4, TRUE, 1),
  (9780261102385, 1000, 1.6, TRUE, 1),
  (9780618968633, 1000, 1.5, TRUE, 1),
  (9780743234900, 1001, 5.0, TRUE, 1),
  (9780743234917, 1001, 5.0, TRUE, 1),
  (9780743234924, 1001, 5.0, TRUE, 1),
  (9781451664829, 1001, 20.0, TRUE, 1);

INSERT INTO `Volume` (`Series_Book_ISBN`, `Volume_Book_ISBN`, `Position`) VALUES
  (9780007525515, 9780261102217, 1),
  (9780007525515, 9780261102354, 2),
  (9780007525515, 9780261102361, 3),
  (9780007525515, 9780261102378, 4),
  (9780060244880, 9780060234812, 2),
  (9780060244880, 9780060234836, 4),
  (9780060244880, 9780060234867, 5),
  (9780060244880, 9780060234881, 3),
  (9780060244880, 9780060234935, 7),
  (9780060244880, 9780060234959, 6),
  (9780060244880, 9780060234973, 1),
  (9780261102385, 9780261102354, 1),
  (9780261102385, 9780261102361, 2),
  (9780261102385, 9780261102378, 3),
  (9781451664829, 9780743234900, 1),
  (9781451664829, 9780743234917, 2),
  (9781451664829, 9780743234924, 3);