CREATE TABLE Companies (
    Company_Id INT IDENTITY(1,1) PRIMARY KEY,
    Company VARCHAR(255),
    Class VARCHAR(50),
    LinkedIn_Followers INT,
    Employee_Count INT,
    Industry VARCHAR(255)
);

INSERT INTO Companies (company, class, LinkedIn_Followers, Employee_count, Industry)
SELECT DISTINCT company_name, class, LinkedIn_Followers, Employee_count, Industry
FROM raw;



CREATE TABLE Job_Postings (
    Job_Posting_ID INT IDENTITY(1,1) PRIMARY KEY ,
    Total_Applicants INT,
    Designation_ID INT,
    Company_ID INT,
    Location_ID INT,
    Level_ID INT,
    Involvement_ID INT  
    FOREIGN Key (Designation_ID) REFERENCES Designations(Designation_ID),
    FOREIGN Key (Company_ID) REFERENCES Companies(Company_ID),
    FOREIGN Key (Location_ID) REFERENCES Locations(Location_ID),
    FOREIGN Key (Level_ID) REFERENCES Levels(Level_ID),
    FOREIGN Key (Involvement_ID) REFERENCES Involvements(Involvement_ID)
);

INSERT INTO Job_Postings (Company_id, Location_id, Level_id, Involvement_id, Designation_id, Total_applicants)
SELECT
    c.Company_ID,
    l.Location_ID,
    lv.Level_ID,
    i.Involvement_ID,
    d.Designation_ID,
    rp.Total_applicants
FROM
    raw rp
    JOIN Companies c ON rp.Company_name = c.Company
    JOIN Locations l ON rp.Location = l.Location
    JOIN Levels lv ON rp.Level = lv.Level
    JOIN Involvements i ON rp.Involvement = i.Involvement
    JOIN Designations d ON rp.Designation = d.Designation;

SELECT * FROm Job_Postings;


CREATE TABLE Job_Postings_Skills(
Job_Posting_ID INT,
Skill_ID INT
FOREIGN Key (Job_Posting_ID) REFERENCES Job_Postings(Job_Posting_ID),
    FOREIGN Key (Skill_ID) REFERENCES Skills(Skill_ID)
    );

INSERT INTO Job_Postings_Skills(Job_Posting_ID, Skill_ID)
(SELECT * FROM raw 
JOIN Job_Postings on Job_Posting_ID=raw_id;
join raw)

CREATE TABLE Designations(
Designation_ID INT IDENTITY(1,1) PRIMARY KEY ,
Designation VARCHAR(50)
);

INSERT INTO Designations(Designation)
(SELECT DISTINCT designation FROM raw);

CREATE TABLE Locations(
Location_ID INT IDENTITY(1,1) PRIMARY KEY ,
Location VARCHAR(50)
);

INSERT INTO Locations(Location)
(SELECT DISTINCT location FROM raw);

CREATE TABLE Skills(
Skill_ID INT IDENTITY(1,1) PRIMARY KEY ,
Skill VARCHAR(50)
)

-- Create the skills table if it doesn't exist
CREATE TABLE Skills (
    Skill_ID INT IDENTITY(1,1) PRIMARY KEY,
    Skill_Name VARCHAR(255) NOT NULL
);


INSERT INTO Skills (Skill)
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'raw'
    AND DATA_TYPE = 'bit';
   

CREATE TABLE Involvements(
Involvement_ID INT IDENTITY(1,1) PRIMARY KEY ,
Involvement VARCHAR(50)
);

INSERT INTO Involvements(Involvement)
(SELECT DISTINCT Involvement FROM raw);

CREATE TABLE Levels(
Level_ID INT IDENTITY(1,1) PRIMARY KEY ,
Level VARCHAR(50)
);

INSERT INTO Levels(Level)
(SELECT DISTINCT Level FROM raw);







SELECT * FROM raw;
SELECT * FROm Companies;
SELECT * FROM Designations;
SELECT * FROm Involvements;
SELECT * FROM Levels;
SELECT * FROM Locations;
SELECT * FROm Job_Postings;
