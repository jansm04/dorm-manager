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
VALUES (3, 2, 'Building 1', 100);
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