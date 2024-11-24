-- drop all tables ignoring constraints
DROP TABLE Dorm CASCADE CONSTRAINTS;
DROP TABLE Building_R2 CASCADE CONSTRAINTS;
DROP TABLE Building_R1 CASCADE CONSTRAINTS;
DROP TABLE Unit CASCADE CONSTRAINTS;
DROP TABLE Room_R1 CASCADE CONSTRAINTS;
DROP TABLE Room_R2 CASCADE CONSTRAINTS;
DROP TABLE PermanentResident CASCADE CONSTRAINTS;
DROP TABLE ResidenceAdvisor CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE MaintenanceRequest CASCADE CONSTRAINTS;
DROP TABLE MaintenanceStaff CASCADE CONSTRAINTS;
DROP TABLE Sublet CASCADE CONSTRAINTS;
DROP TABLE Package CASCADE CONSTRAINTS;


-- NOTE: changed all BOOLEAN types to VARCHAR(5), as BOOLEAN is invalid apparently

CREATE TABLE Dorm (
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) UNIQUE NOT NULL,
    frontDeskOpenTime VARCHAR(10),
    frontDeskCloseTime VARCHAR(10),
    manager VARCHAR(50) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE Building_R2 (
    floors INTEGER NOT NULL,
    washingMachines  INTEGER,
    dryers INTEGER,
    PRIMARY KEY (floors)
);

CREATE TABLE Building_R1 (
    buildingName VARCHAR(50) NOT NULL,
    dormName  VARCHAR(50) NOT NULL,
    yearBuilt INTEGER NOT NULL,
    floors INTEGER NOT NULL,
    PRIMARY KEY (buildingName),
    FOREIGN KEY (dormName) 
        REFERENCES Dorm(name),
    FOREIGN KEY (floors) 
        REFERENCES Building_R2(floors)
        ON DELETE CASCADE
);

CREATE TABLE Unit (
    unitNumber INTEGER NOT NULL, -- changed number -> unitNumber as number can't be used
    buildingName VARCHAR(50) NOT NULL,
    isStudio VARCHAR(5) NOT NULL,
    isShared VARCHAR(5),
    bathrooms INTEGER,
    hasDishwasher VARCHAR(5),
    PRIMARY KEY (unitNumber, buildingName),
    FOREIGN KEY (buildingName) 
        REFERENCES Building_R1(buildingName)
);

CREATE TABLE Room_R1(
    sqFeet INTEGER NOT NULL,
    bedSize VARCHAR(50), -- added size
    PRIMARY KEY (sqFeet)
);

CREATE TABLE Room_R2 (
    roomNumber INTEGER NOT NULL, -- changed number -> roomNumber as number can't be used
    unitNumber INTEGER NOT NULL,
    buildingName VARCHAR(50) NOT NULL,
    sqFeet INTEGER NOT NULL,
    PRIMARY KEY (roomNumber, unitNumber, buildingName),
    FOREIGN KEY (sqFeet) 
        REFERENCES Room_R1(sqFeet)
        ON DELETE CASCADE,
    FOREIGN KEY (unitNumber, buildingName)
        REFERENCES Unit(unitNumber, buildingName)
);

-- removed subletId as Sublet already references PermanentResident with a participation constraint
CREATE TABLE PermanentResident (
    studentId INTEGER NOT NULL,
    roomNumber INTEGER NOT NULL,
    unitNumber INTEGER NOT NULL,
    buildingName VARCHAR(50) NOT NULL,
    -- subletId INTEGER, 
    age INTEGER,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (studentId),
    FOREIGN KEY (roomNumber, unitNumber, buildingName)
        REFERENCES Room_R2 (roomNumber, unitNumber, buildingName)
    -- FOREIGN KEY (subletId)
    --     REFERENCES Student(subletId)
);

CREATE TABLE ResidenceAdvisor ( 
    studentId INTEGER NOT NULL,
    biweeklyWage INTEGER NOT NULL,
    PRIMARY KEY (studentId),
    FOREIGN KEY (studentId) 
        REFERENCES PermanentResident(studentId)
        ON DELETE CASCADE
);

CREATE TABLE Student (
    studentId INTEGER NOT NULL,
    residenceAdvisorId INTEGER NOT NULL,
    strikes INTEGER NOT NULL,
    rent INTEGER NOT NULL,
    PRIMARY KEY (studentId),
    FOREIGN KEY (studentId)
        REFERENCES PermanentResident(studentId)
        ON DELETE CASCADE,
    FOREIGN KEY (residenceAdvisorId) 
        REFERENCES ResidenceAdvisor(studentId)
);

CREATE TABLE MaintenanceStaff ( 
    staffId INTEGER NOT NULL, 
    name VARCHAR(50) NOT NULL, 
    biweeklyWage INTEGER NOT NULL, 
    PRIMARY KEY (staffId) 
);

CREATE TABLE MaintenanceRequest( 
    requestId INTEGER NOT NULL, 
    studentId INTEGER NOT NULL, 
    staffId INTEGER NOT NULL, -- updated to NOT NULL as per milestone 2 feedback
    description VARCHAR(1000) NOT NULL, 
    status VARCHAR(20) NOT NULL, 
    PRIMARY KEY (requestId), 
    FOREIGN KEY (studentId) 
        REFERENCES PermanentResident(studentId), 
    FOREIGN KEY (staffId) 
        REFERENCES MaintenanceStaff(staffId) 
); 

CREATE TABLE Sublet ( 
    studentId INTEGER NOT NULL, 
    residentId INTEGER UNIQUE NOT NULL, 
    name VARCHAR(50) NOT NULL, 
    startDate VARCHAR(50) NOT NULL, 
    endDate VARCHAR(50) NOT NULL, 
    PRIMARY KEY (studentId), 
    FOREIGN KEY (residentId) 
        REFERENCES PermanentResident(studentId) 
);

CREATE TABLE Package ( 
    id INTEGER NOT NULL, 
    studentId INTEGER NOT NULL, 
    mailbox INTEGER NOT NULL, 
    deliveryDate VARCHAR(50), 
    PRIMARY KEY (id), 
    FOREIGN KEY (studentId) 
        REFERENCES PermanentResident(studentId) 
);