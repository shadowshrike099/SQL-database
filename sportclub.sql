-- Step 1: Creating the database
CREATE DATABASE SportsClub;
USE SportsClub;

-- create table Players
CREATE TABLE Players (
    Player_ID INT PRIMARY KEY,
    First_Name VARCHAR(255), 
    Last_Name VARCHAR(255),
    Email VARCHAR(255), 
    Phone_No VARCHAR(10), 
    Date_Of_Birth DATE,
    Address VARCHAR(255), 
    Sport_ID INT, 
    Coach_ID INT,
    FOREIGN KEY (Sport_ID) REFERENCES Sports(Sport_ID), 
    FOREIGN KEY (Coach_ID) REFERENCES Coaches(Coach_ID)
);

-- create table Sports
CREATE TABLE Sports (
    Sport_ID INT PRIMARY KEY,
    Sport_Name VARCHAR(255)
);

-- create table Coaches
CREATE TABLE Coaches (
    Coach_ID INT PRIMARY KEY,
    First_Name VARCHAR(255),
    Last_Name VARCHAR(255)
);

-- create table Inventory
CREATE TABLE Inventory (
    Item_ID INT PRIMARY KEY,
    Item_Name VARCHAR(255),
    Quantity INT,
    Price INT,
    Sport_ID INT,
    FOREIGN KEY (Sport_ID) REFERENCES Sports(Sport_ID)
);

-- create table Courts
CREATE TABLE Courts (
    Court_ID INT PRIMARY KEY,
    Court_Details VARCHAR(255)
);

-- create table Games
CREATE TABLE Games (
    Game_ID INT PRIMARY KEY,
    Title VARCHAR(255),
    Date DATE,
    Time TIME,
    Sport_ID INT,
    Court_ID INT,
    FOREIGN KEY (Sport_ID) REFERENCES Sports(Sport_ID),
    FOREIGN KEY (Court_ID) REFERENCES Courts(Court_ID)
);

-- create table Staff
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    First_Name VARCHAR(255),
    Last_Name VARCHAR(255),
    Email VARCHAR(255),
    Phone_No VARCHAR(10),
    Address VARCHAR(255),
    Position VARCHAR(255),
    Hire_Date DATE,
    Is_Coach VARCHAR(255),
    Coach_ID INT,
    Shift VARCHAR(255),
    FOREIGN KEY (Coach_ID) REFERENCES Coaches(Coach_ID)
);

-- Insert data into 'Sports' table
INSERT INTO Sports (Sport_ID, Sport_Name) VALUES
(1, 'Basketball'),
(2, 'Tennis'),
(3, 'Football'),
(4, 'Volleyball'),
(5, 'Swimming');

-- Insert data into 'Coaches' table
INSERT INTO Coaches (Coach_ID, First_Name, Last_Name) VALUES
(1, 'Subash', 'Mandal'),
(2, 'Sandip', 'Gurung'),
(3, 'Arjun', 'Yadav'),
(4, 'Rajan', 'Ansari'),
(5, 'Sayar', 'Shrestha');

-- Insert data into 'Players' table and phone numbers
INSERT INTO Players (Player_ID, First_Name, Last_Name, Email,
Phone_No, Date_Of_Birth, Address, Sport_ID, Coach_ID) VALUES
(1, 'Rahul', 'Shrestha', 'rahul12@email.com', '982484232', '2000-06-12', 'Janakpur', 1, 1),
(2, 'Sabita', 'Pandey', 'pandeysabita@email. com', '988724424', '2004-05-22', 'Kathmandu', 2, 2),
(3, 'Prashant', 'Sunam', 'prashant1143@email.com', '97723443', '1999-06-12', 'Okhaldhunga', 3, 3),
(4, 'Arju', 'Bhandari', 'arjubhand@email.com', '955756757', '1998-11-13', 'Dhading', 4, 4),
(5, 'Sujan', 'Mahato', 'mahato@email.com', '98353455', '1996-04-03', 'Bhojpur', 5, 5);

-- Insert data into 'Inventory' table
INSERT INTO Inventory (Item_ID, Item_Name, Quantity, Price, Sport_ID) VALUES
(1, 'Basketball', 5, 20.99, 1),
(2, 'Tennis Racket', 10, 110.50, 2),
(3, 'Football', 15, 30.00, 3),
(4, 'Volleyball Net', 20, 65.75, 4),
(5, 'Swim Goggles', 25, 12.99, 5);

-- Insert data into 'Courts' table
INSERT INTO Courts (Court_ID, Court_Details) VALUES
(1, 'Basketball Court'),
(2, 'Football Court'),
(3, 'Badminton Ground'),
(4, 'Table tennis Court'),
(5, 'Swimming Pool');

-- Insert data into 'Games' table
INSERT INTO Games (Game_ID, Title, Date, Time, Sport_ID, Court_ID) VALUES
(1, 'Junior Boys Basketball competition', '2024-02-17', '13:00:00', 1, 1),
(2, 'Basbari Futsal tournament', '2024-03-13', '14:00:00', 2, 2),
(3, 'INter school competition', '2024-04-14', '15:30:00', 3, 3),
(4, 'Intra school competition', '2024-05-15', '16:45:00', 4, 4),
(5, '100m Swimming Competition', '2024-06-16', '12:00:00', 5, 5);


-- Insert data into 'Staff' table
INSERT INTO Staff (Staff_ID, First_Name, Last_Name, Email, Phone_No, Address, Position, Hire_Date, Is_Coach, Coach_ID, Shift) VALUES
(1, 'Subash', 'Mandal', 'subashmandal@email.com', '984934434', 'Saptari', 'Manager', '2020-06-18', 'yes', 1, 'Morning'),
(2, 'Apsara', 'Poudel', 'apsara@email.com', '984372321', 'Lalitpur', 'Accountant', '2022-06-10', 'no', NULL, 'Day'),
(3, 'Phurba', 'Tamang', 'phurba4@email.com', '981234234', 'Nuwakot', 'Coach', '2023-08-09', 'no', NULL, 'Night'),
(4, 'Utsav', 'Ranjit', 'ranjit@email.com', '981321222', 'Bhaktapur', 'Technician', '2021-11-10', 'no', NULL, 'Morning'),
(5, 'Suraj', 'Thankur', 'suraj@email.com', '984312000', 'Siraha', 'Receptionist', '2022-06-15', 'no', NULL, 'Day');


-- Query to select all players who have participated in any game
SELECT p.Player_ID, p.First_Name, p.Last_Name, GROUP_CONCAT(g.Title) AS Played_Titles
FROM Players p
JOIN Games g ON p.Sport_ID = g.Sport_ID
GROUP BY p.Player_ID, p.First_Name, p.Last_Name;

-- Query to select all staff members who are coaches.
SELECT Staff_ID, First_Name, last_Name, Coach_ID FROM Staff WHERE Is_Coach = 'yes';

-- Query that counts the total number of items in the inventory
SELECT COUNT(*) AS Total_Items FROM Inventory;

-- Query to select all staff members working in the morning and the day shift
SELECT * FROM Staff WHERE Shift IN ('Morning', 'Day');

-- Update the shift of one staff member from morning to day shift
UPDATE Staff SET Shift = 'Day' WHERE Staff_ID = 1;

-- Delete all players who were born before 2000.
DELETE FROM Players WHERE YEAR(Date_Of_Birth) < 2000;

