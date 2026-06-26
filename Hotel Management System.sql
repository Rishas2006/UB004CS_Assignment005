-- HOTEL MANAGEMENT SYSTEM --

-- CREATE NEW DATABASE (HotelManagement) --
CREATE DATABASE HotelManagement;

-- SELECT THE HotelManagement DATABASE --
USE HotelManagement;

-- Create Guest Table --
CREATE TABLE Guest (
    Guest_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);
SELECT * FROM Guest;

-- Create Room_Type Table --
CREATE TABLE Room_Type (
    Type_ID INT PRIMARY KEY,
    Type_Name VARCHAR(50) NOT NULL,
    Price_Per_Night DECIMAL(10, 2) NOT NULL,
    CONSTRAINT CHK_Price CHECK (Price_Per_Night > 0)
);
SELECT * FROM Room_Type;

-- Create Staff Table --
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Staff_Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2),
    CONSTRAINT CHK_Salary CHECK (Salary >= 0)
);
SELECT * FROM Staff;

-- Create Room Table --
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Number VARCHAR(10) UNIQUE,
    Type_ID INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Available',
    FOREIGN KEY (Type_ID) REFERENCES Room_Type(Type_ID),
    CONSTRAINT CHK_Status CHECK (Status IN ('Available', 'Occupied', 'Maintenance'))
);
SELECT * FROM Room;

-- Create Booking Table --
CREATE TABLE Booking (
    Booking_ID INT PRIMARY KEY,
    Guest_ID INT NOT NULL,
    Room_ID INT NOT NULL,
    Staff_ID INT NOT NULL,
    Check_In_Date DATE NOT NULL,
    Check_Out_Date DATE NOT NULL,
    Total_Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    CONSTRAINT CHK_Booking_Dates CHECK (Check_Out_Date > Check_In_Date),
    CONSTRAINT CHK_Total_Amount CHECK (Total_Amount >= 0)
);
SELECT * FROM Booking;

-- Create Payment Table
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Booking_ID INT UNIQUE,
    Payment_Date DATE NOT NULL,
    Payment_Method VARCHAR(50) NOT NULL,
    Amount_Paid DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (Booking_ID) REFERENCES Booking(Booking_ID),
    CONSTRAINT CHK_Amount_Paid CHECK (Amount_Paid >= 0)
);
SELECT * FROM Payment;

-- INSERT DATA INTO GUEST --
INSERT INTO Guest (Guest_ID,First_Name, Last_Name, Email, Phone, Address) VALUES
(1,'John', 'Doe', 'john.doe@email.com', '555-0101', '123 Maple St, Seattle'),
(2,'Jane', 'Smith', 'jane.smith@email.com', '555-0102', '456 Oak Ave, Boston'),
(3,'Robert', 'Johnson', 'robert.j@email.com', '555-0103', '789 Pine Rd, Chicago'),
(4,'Emily', 'Davis', 'emily.d@email.com', '555-0104', '321 Elm St, New York'),
(5,'Michael', 'Brown', 'michael.b@email.com', '555-0105', '654 Spruce St, Austin'),
(6,'Linda', 'Miller', 'linda.m@email.com', '555-0106', '987 Cedar Ln, Miami'),
(7,'William', 'Wilson', 'william.w@email.com', '555-0107', '147 Birch Blvd, Denver'),
(8,'Elizabeth', 'Moore', 'elizabeth.m@email.com', '555-0108', '258 Walnut Ct, Phoenix'),
(9,'David', 'Taylor', 'david.t@email.com', '555-0109', '369 Ash Dr, San Diego'),
(10,'Susan', 'Anderson', 'susan.a@email.com', '555-0110', '741 Cherry Way, Portland');

-- View inserted data from Guest table --
SELECT * FROM Guest;

-- INSERT DATA INTO ROOM_TYPE --
INSERT INTO Room_Type (Type_ID,Type_Name, Price_Per_Night) VALUES
(1,'Standard Single', 50.00),
(2,'Standard Double', 85.00),
(3,'Deluxe Suite', 150.00),
(4,'Presidential Suite', 450.00);

-- View inserted data from Room_Type table --
SELECT * FROM Room_Type;

-- INSERT DATA INTO STAFF --
INSERT INTO Staff (Staff_ID, Staff_Name, Role, Salary) VALUES
(1,'Alice Green', 'Receptionist', 3200.00),
(2,'Bob White', 'Receptionist', 3200.00),
(3,'Charlie Black', 'Hotel Manager', 6500.00),
(4,'Diana Prince', 'Housekeeper', 2500.00),
(5,'Evan Wright', 'Housekeeper', 2500.00),
(6,'Fiona Gallagher', 'Chef', 4200.00),
(7,'George Clark', 'Bellhop', 2200.00),
(8,'Hannah Abbott', 'Concierge', 3500.00),
(9,'Ian Malcolm', 'Security', 2800.00),
(10,'Julia Roberts', 'Marketing', 4800.00);

-- View inserted data from Staff table --
SELECT * FROM Staff;

-- INSERT DATA INTO ROOM --
INSERT INTO Room (Room_ID, Room_Number, Type_ID, Status) VALUES
(1,'101', 1, 'Available'),
(2,'102', 1, 'Available'),
(3,'103', 1, 'Maintenance'),
(4,'201', 2, 'Occupied'),
(5,'202', 2, 'Available'),
(6,'203', 2, 'Occupied'),
(7,'301', 3, 'Occupied'),
(8,'302', 3, 'Available'),
(9,'401', 4, 'Occupied'),
(10,'402', 4, 'Available');

-- View inserted data from Room table --
SELECT * FROM Room;

-- INSERT DATA INTO BOOKING --
INSERT INTO Booking (Booking_ID, Guest_ID, Room_ID, Staff_ID, Check_In_Date, Check_Out_Date, Total_Amount) VALUES
(1, 1, 1, 1, '2026-05-01', '2026-05-03', 100.00),
(2, 2, 4, 1, '2026-05-01', '2026-05-05', 340.00),
(3, 3, 7, 2, '2026-05-02', '2026-05-04', 300.00),
(4, 4, 9, 2, '2026-05-10', '2026-05-12', 900.00),
(5, 5, 2, 1, '2026-05-12', '2026-05-15', 150.00),
(6, 6, 5, 2, '2026-05-15', '2026-05-17', 170.00),
(7, 7, 6, 1, '2026-05-18', '2026-05-22', 340.00),
(8, 8, 8, 2, '2026-05-20', '2026-05-25', 750.00),
(9, 9, 10, 1, '2026-05-22', '2026-05-23', 450.00),
(10, 10, 3, 2, '2026-05-24', '2026-05-27', 150.00),
(11, 1, 4, 1, '2026-06-01', '2026-06-03', 170.00),
(12, 2, 7, 2, '2026-06-05', '2026-06-09', 600.00),
(13, 3, 1, 1, '2026-06-10', '2026-06-11', 50.00),
(14, 4, 6, 2, '2026-06-12', '2026-06-14', 170.00),
(15, 5, 9, 1, '2026-06-15', '2026-06-18', 1350.00);

-- View inserted data from Booking table --
SELECT * FROM Booking;

-- INSERT DATA INTO PAYMENT --
INSERT INTO Payment (Payment_ID, Booking_ID, Payment_Date, Payment_Method, Amount_Paid) VALUES
(1, 1, '2026-05-03', 'Cash', 100.00),
(2, 2, '2026-05-05', 'Credit Card', 340.00),
(3, 3, '2026-05-04', 'Credit Card', 300.00),
(4, 4, '2026-05-12', 'Debit Card', 900.00),
(5, 5, '2026-05-15', 'Cash', 150.00),
(6, 6, '2026-05-17', 'Credit Card', 170.00),
(7, 7, '2026-05-22', 'Digital Wallet', 340.00),
(8, 8, '2026-05-25', 'Credit Card', 750.00),
(9, 9, '2026-05-23', 'Cash', 450.00),
(10, 10, '2026-05-27', 'Debit Card', 150.00),
(11, 11, '2026-06-03', 'Credit Card', 170.00),
(12, 12, '2026-06-09', 'Digital Wallet', 600.00),
(13, 13, '2026-06-11', 'Cash', 50.00),
(14, 14, '2026-06-14', 'Credit Card', 170.00),
(15, 15, '2026-06-18', 'Credit Card', 1350.00);

-- View inserted data from Payment table --
SELECT * FROM Payment;

---- VIEW INSTERED DATA FROM ROOM TABLE --
SELECT * FROM Room;

-- SELECT specific columns --
SELECT Staff_Name, Role, Salary FROM Staff;

-- WHERE Clause --
SELECT * FROM Payment 
WHERE Payment_Method = 'Credit Card';

-- ORDER BY --
SELECT * FROM Guest 
ORDER BY Last_Name ASC, First_Name ASC;

-- LIKE Operator --
SELECT Guest_ID, First_Name, Last_Name, Email 
FROM Guest 
WHERE Email LIKE '%@email.com';

-- INNER JOIN --
SELECT 
    B.Booking_ID, 
    G.First_Name, 
    G.Last_Name, 
    R.Room_Number, 
    B.Check_In_Date, 
    B.Check_Out_Date
FROM Booking B
INNER JOIN Guest G ON B.Guest_ID = G.Guest_ID
INNER JOIN Room R ON B.Room_ID = R.Room_ID;

-- LEFT JOIN --
SELECT 
    R.Room_Number, 
    R.Status, 
    B.Booking_ID, 
    B.Check_In_Date
FROM Room R
LEFT JOIN Booking B ON R.Room_ID = B.Room_ID;

-- RIGHT JOIN --
SELECT 
    B.Booking_ID, 
    B.Total_Amount, 
    P.Payment_ID, 
    P.Amount_Paid, 
    P.Payment_Method
FROM Booking B
RIGHT JOIN Payment P ON B.Booking_ID = P.Booking_ID;

-- GROUP BY --
SELECT 
    Role, 
    SUM(Salary) AS Total_SalaryBudget
FROM Staff
GROUP BY Role;

-- COUNT() --
SELECT 
    RT.Type_Name, 
    COUNT(B.Booking_ID) AS Total_Bookings_Count
FROM Room_Type RT
INNER JOIN Room R ON RT.Type_ID = R.Type_ID
LEFT JOIN Booking B ON R.Room_ID = B.Room_ID
GROUP BY RT.Type_Name;

-- DATABASE REPORT --
-- Report 1: Room Ocupancy & Popularity Summary --
SELECT 
    RT.Type_Name AS 'Room Category',
    COUNT(B.Booking_ID) AS 'Total Bookings',
    SUM(B.Total_Amount) AS 'Gross Revenue Generated',
    AVG(B.Total_Amount) AS 'Average Booking Value'
FROM Room_Type RT
INNER JOIN Room R ON RT.Type_ID = R.Type_ID
LEFT JOIN Booking B ON R.Room_ID = B.Room_ID
GROUP BY RT.Type_Name
ORDER BY 'Total Bookings' DESC;

-- Report 2: Guest Financial Settlements Ledger --
SELECT 
    B.Booking_ID AS 'Booking Reference',
    CONCAT(G.First_Name, ' ', G.Last_Name) AS 'Guest Name',
    R.Room_Number AS 'Room Assigned',
    B.Total_Amount AS 'Invoice Cost',
    P.Amount_Paid AS 'Total Paid',
    (B.Total_Amount - P.Amount_Paid) AS 'Outstanding Balance Summary',
    P.Payment_Method AS 'Settlement Method'
FROM Booking B
INNER JOIN Guest G ON B.Guest_ID = G.Guest_ID
INNER JOIN Room R ON B.Room_ID = R.Room_ID
INNER JOIN Payment P ON B.Booking_ID = P.Booking_ID
WHERE (B.Total_Amount - P.Amount_Paid) <> 0 OR P.Payment_ID IS NULL;

-- Report 3: Front Desk Receptionist Performance Metrics --
SELECT 
    S.Staff_ID AS 'Staff ID',
    S.Staff_Name AS 'Employee Name',
    S.Role AS 'Job Title',
    COUNT(B.Booking_ID) AS 'Reservations Formatted',
    SUM(B.Total_Amount) AS 'Total Sales Vol'
FROM Staff S
LEFT JOIN Booking B ON S.Staff_ID = B.Staff_ID
WHERE S.Role = 'Receptionist'
GROUP BY S.Staff_ID, S.Staff_Name, S.Role
ORDER BY 'Total Sales Vol' DESC;