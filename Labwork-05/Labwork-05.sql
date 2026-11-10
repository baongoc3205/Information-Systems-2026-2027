-- Labwork 05 - DB Design

-- Exercise 1: Magazine database design

DROP DATABASE IF EXISTS magazine_db;
CREATE DATABASE magazine_db;
USE magazine_db;

-- 1. Table: Magazine
CREATE TABLE MAGAZINE (
    ISSN VARCHAR(20) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Number INT NOT NULL,
    Year INT NOT NULL,
    PRIMARY KEY (ISSN, Number, Year)
);

-- 2. Table: Article
CREATE TABLE ARTICLE (
    ArticleTitle VARCHAR(255) NOT NULL,
    StartPage INT NOT NULL,
    EndPage INT NOT NULL,
    ISSN VARCHAR(20) NOT NULL,
    Number INT NOT NULL,
    Year INT NOT NULL,
    PRIMARY KEY (ArticleTitle),
    FOREIGN KEY (ISSN, Number, Year) REFERENCES MAGAZINE(ISSN, Number, Year)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 3. Table: Author
CREATE TABLE AUTHOR (
    Email VARCHAR(255) NOT NULL,
    AuthorName VARCHAR(255) NOT NULL,
    Affiliation VARCHAR(255),
    PRIMARY KEY (Email)
);

-- 4. Table: Article_author
CREATE TABLE ARTICLE_AUTHOR (
    ArticleTitle VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    AuthorOrder INT NOT NULL,
    PRIMARY KEY (ArticleTitle, Email),
    FOREIGN KEY (ArticleTitle) REFERENCES ARTICLE(ArticleTitle)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (Email) REFERENCES AUTHOR(Email)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Describe tables for Exercise 1
DESCRIBE MAGAZINE;
DESCRIBE ARTICLE;
DESCRIBE AUTHOR;
DESCRIBE ARTICLE_AUTHOR;


-- Exercise 2: NGO database design

DROP DATABASE IF EXISTS ngo_db;
CREATE DATABASE ngo_db;
USE ngo_db;

-- 1. Table: Head_office
CREATE TABLE HEAD_OFFICE (
    OfficeID INT NOT NULL AUTO_INCREMENT,
    City VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    DirectorName VARCHAR(100) NOT NULL,
    PRIMARY KEY (OfficeID)
);

-- 2. Table: Project
CREATE TABLE PROJECT (
    ProjectCode VARCHAR(50) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget DECIMAL(15, 2) NOT NULL,
    PersonInCharge VARCHAR(100) NOT NULL,
    OfficeID INT NOT NULL,
    PRIMARY KEY (ProjectCode),
    FOREIGN KEY (OfficeID) REFERENCES HEAD_OFFICE(OfficeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 3. Table: Action
CREATE TABLE ACTION (
    ActionID INT NOT NULL AUTO_INCREMENT,
    Description TEXT NOT NULL,
    ProjectCode VARCHAR(50) NOT NULL,
    PRIMARY KEY (ActionID),
    FOREIGN KEY (ProjectCode) REFERENCES PROJECT(ProjectCode)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 4. Table: City
CREATE TABLE CITY (
    CityID INT NOT NULL AUTO_INCREMENT,
    CityName VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    Population INT NOT NULL,
    PRIMARY KEY (CityID)
);

-- 5. Table: Project_city
CREATE TABLE PROJECT_CITY (
    ProjectCode VARCHAR(50) NOT NULL,
    CityID INT NOT NULL,
    Investment DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (ProjectCode, CityID),
    FOREIGN KEY (ProjectCode) REFERENCES PROJECT(ProjectCode)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (CityID) REFERENCES CITY(CityID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 6. Table: Action_city
CREATE TABLE ACTION_CITY (
    ActionID INT NOT NULL,
    CityID INT NOT NULL,
    PRIMARY KEY (ActionID, CityID),
    FOREIGN KEY (ActionID) REFERENCES ACTION(ActionID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (CityID) REFERENCES CITY(CityID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Describe tables for Exercise 2
DESCRIBE HEAD_OFFICE;
DESCRIBE PROJECT;
DESCRIBE ACTION;
DESCRIBE CITY;
DESCRIBE PROJECT_CITY;
DESCRIBE ACTION_CITY;

