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
    startDate DATE NOT NULL, 
    endDate DATE NOT NULL, 
    PRIMARY KEY (studentId), 
    FOREIGN KEY (residentId) 
        REFERENCES PermanentResident(studentId) 
);

CREATE TABLE Package ( 
    id INTEGER NOT NULL, 
    studentId INTEGER NOT NULL, 
    mailbox INTEGER NOT NULL, 
    deliveryDate DATE, 
    PRIMARY KEY (id), 
    FOREIGN KEY (studentId) 
        REFERENCES PermanentResident(studentId) 
);

INSERT INTO Dorm (name, address, frontDeskOpenTime, frontDeskCloseTime, manager) 
VALUES ('Marine Drive', '2205 Lower Mall, Vancouver, BC V6T 1Z4', '9:00', '22:00', 'Malak Aiad');
INSERT INTO Dorm (name, address, frontDeskOpenTime, frontDeskCloseTime, manager) 
VALUES ('Exchange', '5955 Student Union Blvd, Vancouver, BC V6T 1K2', '9:00', '22:00', 'Jennifer Gunn');
INSERT INTO Dorm (name, address, frontDeskOpenTime, frontDeskCloseTime, manager) 
VALUES ('Ponderosa Commons', '2075 West Mall, Vancouver, BC V6T 1Z2', '9:00', '22:00', 'Jane Doe');
INSERT INTO Dorm (name, address, frontDeskOpenTime, frontDeskCloseTime, manager) 
VALUES ('Orchard Commons', '6363 Agronomy Road, Vancouver, BC V6T 1Z4', '9:00', '22:00', 'Calvin Cheung');
INSERT INTO Dorm (name, address, frontDeskOpenTime, frontDeskCloseTime, manager) 
VALUES ('Walter Gage', '5959 Student Union Blvd. Vancouver, BC V6T 1K2', '9:00', '22:00', 'Eniola Folarin');

INSERT INTO Building_R2 (floors, washingMachines, dryers) VALUES (4, 4, 4);
INSERT INTO Building_R2 (floors, washingMachines, dryers) VALUES (6, 6, 6);
INSERT INTO Building_R2 (floors, washingMachines, dryers) VALUES (24, 10, 10);
INSERT INTO Building_R2 (floors, washingMachines, dryers) VALUES (10, 8, 8);
INSERT INTO Building_R2 (floors, washingMachines, dryers) VALUES (17, 8, 8);

INSERT INTO Building_R1 (buildingName, dormName, yearBuilt, floors) 
VALUES ('Building 1', 'Marine Drive', 2000, 17);
INSERT INTO Building_R1 (buildingName, dormName, yearBuilt, floors) 
VALUES ('Building 2', 'Marine Drive', 2007, 10);
INSERT INTO Building_R1 (buildingName, dormName, yearBuilt, floors) 
VALUES ('Oak', 'Ponderosa Commons', 2000, 24);
INSERT INTO Building_R1 (buildingName, dormName, yearBuilt, floors) 
VALUES ('Cedar', 'Ponderosa Commons', 2001, 24);
INSERT INTO Building_R1 (buildingName, dormName, yearBuilt, floors) 
VALUES ('Braeburn', 'Orchard Commons', 2016, 24);

INSERT INTO Unit (unitNumber, buildingName, isStudio, isShared, bathrooms, hasDishwasher) 
VALUES (1, 'Building 1', 1, 0, 1, 0);
INSERT INTO Unit (unitNumber, buildingName, isStudio, isShared, bathrooms, hasDishwasher) 
VALUES (2, 'Building 1', 0, 1, 2, 0);
INSERT INTO Unit (unitNumber, buildingName, isStudio, isShared, bathrooms, hasDishwasher) 
VALUES (6, 'Building 2', 0, 1, 2, 0);
INSERT INTO Unit (unitNumber, buildingName, isStudio, isShared, bathrooms, hasDishwasher) 
VALUES (7, 'Building 2', 1, 0, 1, 0);
INSERT INTO Unit (unitNumber, buildingName, isStudio, isShared, bathrooms, hasDishwasher) 
VALUES (11, 'Braeburn', 1, 1, 1, 1);

INSERT INTO Room_R1 (sqFeet, bedSize) VALUES (80, 'Twin XL');
INSERT INTO Room_R1 (sqFeet, bedSize) VALUES (100, 'Twin XL');
INSERT INTO Room_R1 (sqFeet, bedSize) VALUES (120, 'Twin XL');
INSERT INTO Room_R1 (sqFeet, bedSize) VALUES (200, 'Queen');
INSERT INTO Room_R1 (sqFeet, bedSize) VALUES (250, 'Queen');

INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (2, 1, 'Building 1', 100);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (1, 2, 'Building 1', 100);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (2, 2, 'Building 1', 80);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (3, 1, 'Building 1', 250);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (4, 1, 'Building 1', 200);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (3, 2, 'Building 1', 120);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (4, 2, 'Building 1', 100);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (2, 6, 'Building 2', 120);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (1, 7, 'Building 2', 200);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (2, 7, 'Building 2', 200);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (1, 11, 'Braeburn', 250);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (2, 11, 'Braeburn', 250);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (3, 11, 'Braeburn', 250);
INSERT INTO Room_R2 (roomNumber, unitNumber, buildingName, sqFeet) 
VALUES (4, 11, 'Braeburn', 250);

INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (13849148, 2, 1, 'Building 1', 20, 'William Nylander', 'willy@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (71849184, 1, 2, 'Building 1', 21, 'Morgan Reilly', 'mo.reilly@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (81941048, 3, 2, 'Building 1', 20, 'Jane Matthews', 'jane.matthews@hotmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (48105829, 2, 6, 'Building 2', 19, 'Emily Marner', 'emily.marner@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (71193810, 1, 7, 'Building 2', 22, 'Anna Tanev', 'anna.tanev@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (82957194, 2, 7, 'Building 2', 22, 'John Tavares', 'jt91@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (12368295, 1, 11, 'Braeburn', 20, 'Calle Jarnkrok', 'calle.j@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (22385013, 2, 11, 'Braeburn', 21, 'Mae Dae', 'mdae@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (44185018, 3, 11, 'Braeburn', 22, 'Ally Sing', 'asing@gmail.com');
INSERT INTO PermanentResident (studentId, roomNumber, unitNumber, buildingName, age, name, email) 
VALUES (28492572, 4, 11, 'Braeburn', 19, 'Sarah Robertson', 's.robo@gmail.com');

INSERT INTO ResidenceAdvisor (studentId, biweeklyWage) VALUES (13849148, 500);
INSERT INTO ResidenceAdvisor (studentId, biweeklyWage) VALUES (71849184, 600);
INSERT INTO ResidenceAdvisor (studentId, biweeklyWage) VALUES (81941048, 450);
INSERT INTO ResidenceAdvisor (studentId, biweeklyWage) VALUES (48105829, 500);
INSERT INTO ResidenceAdvisor (studentId, biweeklyWage) VALUES (71193810, 700);

INSERT INTO Student (studentId, residenceAdvisorId, strikes, rent) 
VALUES (82957194, 13849148, 0, 1000);
INSERT INTO Student (studentId, residenceAdvisorId, strikes, rent) 
VALUES (12368295, 71849184, 0, 1100);
INSERT INTO Student (studentId, residenceAdvisorId, strikes, rent) 
VALUES (22385013, 81941048, 0, 1100);
INSERT INTO Student (studentId, residenceAdvisorId, strikes, rent) 
VALUES (44185018, 48105829, 0, 1000);
INSERT INTO Student (studentId, residenceAdvisorId, strikes, rent) 
VALUES (28492572, 71193810, 1, 750);

INSERT INTO MaintenanceStaff (staffId, name, biweeklyWage) 
VALUES (435214, 'Jan Smailbegovic', 2105);
INSERT INTO MaintenanceStaff (staffId, name, biweeklyWage) 
VALUES (913037, 'Aayush Behl', 2067);
INSERT INTO MaintenanceStaff (staffId, name, biweeklyWage) 
VALUES (323271, 'Alex Briauzov', 1999);
INSERT INTO MaintenanceStaff (staffId, name, biweeklyWage) 
VALUES (837249, 'Penny West', 2450);
INSERT INTO MaintenanceStaff (staffId, name, biweeklyWage) 
VALUES (174528, 'Ben Stiller', 2750);

INSERT INTO MaintenanceRequest (requestId, studentId, staffId, description, status) 
VALUES (74272757, 82957194, 913037, 'broken dishwasher', 'submitted');
INSERT INTO MaintenanceRequest (requestId, studentId, staffId, description, status) 
VALUES (47827528, 71849184, 435214, 'air conditioning not working', 'assigned');
INSERT INTO MaintenanceRequest (requestId, studentId, staffId, description, status) 
VALUES (17492753, 44185018, 837249, 'magnets on fridge fell off', 'complete');
INSERT INTO MaintenanceRequest (requestId, studentId, staffId, description, status) 
VALUES (15859324, 28492572, 323271, 'our light bulb broke', 'submitted');
INSERT INTO MaintenanceRequest (requestId, studentId, staffId, description, status) 
VALUES (82957295, 28492572, 323271, 'need a new chair for my room', 'submitted');

INSERT INTO Sublet (studentId, residentId, name, startDate, endDate) 
VALUES (12345678, 28492572, 'Jeffrey Lew', TO_DATE('20-SEP-2024', 'DD-MON-YYYY'), TO_DATE('01-DEC-2024', 'DD-MON-YYYY'));
INSERT INTO Sublet (studentId, residentId, name, startDate, endDate) 
VALUES (82957194, 12368295, 'Jack Reacher', TO_DATE('01-SEP-2023', 'DD-MON-YYYY'), TO_DATE('01-JAN-2024', 'DD-MON-YYYY'));
INSERT INTO Sublet (studentId, residentId, name, startDate, endDate) 
VALUES (34568213, 13849148, 'Matthew Scott', TO_DATE('01-JAN-2024', 'DD-MON-YYYY'), TO_DATE('01-DEC-2024', 'DD-MON-YYYY'));
INSERT INTO Sublet (studentId, residentId, name, startDate, endDate) 
VALUES (15154466, 48105829, 'Mathias Der', TO_DATE('18-SEP-2022', 'DD-MON-YYYY'), TO_DATE('31-DEC-2022', 'DD-MON-YYYY'));
INSERT INTO Sublet (studentId, residentId, name, startDate, endDate) 
VALUES (78755003, 44185018, 'Will Bjorn', TO_DATE('20-SEP-2024', 'DD-MON-YYYY'), TO_DATE('01-DEC-2024', 'DD-MON-YYYY'));

INSERT INTO Package (id, studentId, mailbox, deliveryDate) 
VALUES (12842953, 12368295, 22, TO_DATE('27-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO Package (id, studentId, mailbox, deliveryDate) 
VALUES (72957295, 12368295, 4, TO_DATE('12-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO Package (id, studentId, mailbox, deliveryDate) 
VALUES (29492482, 44185018, 11, TO_DATE('02-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO Package (id, studentId, mailbox, deliveryDate) 
VALUES (56275925, 13849148, 7, TO_DATE('30-OCT-2024', 'DD-MON-YYYY'));
INSERT INTO Package (id, studentId, mailbox, deliveryDate) 
VALUES (48592853, 28492572, 5, TO_DATE('02-NOV-2024', 'DD-MON-YYYY'));
