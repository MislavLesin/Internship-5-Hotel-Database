CREATE DATABASE DUMPDomaci

create table Hotels(
	id int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(50) NOT NULL,
	Location nvarchar(70) NOT NULL
)

create table StaffWorkTypes(
	id int IDENTITY(1,1) PRIMARY KEY,
	Type nvarchar(50) NOT NULL,
	Description nvarchar(150)
)


create table Staff 
(
	id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(30) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	OIB nvarchar(8) NOT NULL,
	DateOfBirth DateTime2,
	HotelId int FOREIGN KEY REFERENCES Hotels(id)  NOT NULL,
	StaffWorkType int FOREIGN KEY REFERENCES StaffWorkTypes(id)  NOT NULL
)


create table Customer 
(
	id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(30) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	OIB nvarchar(8) NOT NULL,
	DateOfBirth DateTime2,
	IsFrom nvarchar(30)
)

create table RoomTypes(
	id int IDENTITY(1,1) PRIMARY KEY,
	Type nvarChar(50) NOT NULL,
	Description nvarchar(60)
)


create table Rooms(
	id int IDENTITY(1,1) PRIMARY KEY,
	Number int NOT NULL,
	Price float NOT NULL,
	Capacity int NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(id) NOT NULL,
	RoomTypeId int FOREIGN KEY REFERENCES RoomTypes(id) NOT NULL
)

create table VisittingPeople 
(
	id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(30) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	OIB nvarchar(8) NOT NULL,
	DateOfBirth DateTime2,
	Email nvarchar(40)
)


create table PansionTypes 
(
	id int IDENTITY(1,1) PRIMARY KEY,
	PansionType nvarchar(20) NOT NULL,
	PansionDescription nvarchar(60)
)


create table Reservations(
	id int IDENTITY(1,1) PRIMARY KEY,
	DateOfArrival Datetime2 NOT NULL,
	DateOfDeparture Datetime2 NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(id) NOT NULL
)

create table ReservationsVisittingPeople(
	VisittingPeopleId int FOREIGN KEY REFERENCES VisittingPeople(id) NOT NULL,
	ReservationId int FOREIGN KEY REFERENCES Reservations(id) NOT NULL,
	CONSTRAINT ReservationVisittingPrimaryKey PRIMARY KEY (VisittingPeopleId,ReservationId)
)

/*
USE DUMPDomaci;
EXEC sp_configure 'clr enabled' ,1
GO

RECONFIGURE
GO
EXEC sp_configure 'clr enabled'   -- make sure it took
GO

USE DUMPDomaci
GO

EXEC sp_changedbowner 'sa'
USE TestDatabase
GO

-- ovo san nasa na stackoverflow, nije mi tia napravit dijagram bez ovoga...
*/

create table Customer 
(
	id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(30) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	OIB nvarchar(8) NOT NULL,
	DateOfBirth DateTime2,
	IsFrom nvarchar(30)
)

create table Purchase 
(
	id int IDENTITY(1,1) PRIMARY KEY,
	DateOfPurchase DateTime2 NOT NULL,
	Price float NOT NULL,
	CustomerId int FOREIGN KEY REFERENCES Customer(id) NOT NULL,
	PansionTypeId int FOREIGN KEY REFERENCES PansionTypes(id) NOT NULL,
	ReservationsId int FOREIGN KEY REFERENCES Reservations(id) NOT NULL
)

-----------------------------------------------------------------------------
-----unosenje podataka: 


insert into PansionTypes(PansionType , PansionDescription) VALUES
('Full pansion','Brekfast, Lunch and Dinner '),
('Half pansion','Brekfast only'),
('No pansion','') 


insert into StaffWorkTypes(Type , Description) VALUES
('House keeping','Does all the cleaning in hotel'),
('Manager','Makes sure everyone does their job'),
('Concierge','Helps customers with their luggage and cars'),
('Cook','Official hotel cheff'),
('Receptionist','Works the receprion of hotel')


insert into Hotels(Name , Location) VALUES
('Marmont','Center of Split'),
('Park','Hvar Croatia'),
('Antunovic','Zagreb'),
('Amoretta','West Split'),
('Dioklecian','Dicletians Palace Split')


insert into Staff(FirstName ,LastName,OIB,DateOfBirth,HotelId,StaffWorkType) VALUES
('Marko','Markic', '123-456', '1992-6-12',1,1),
('Ivan','Ivkovic', '893-126', '1990-2-23',2,1),
('Ante','Antic', '656-456', '1986-9-1',1,2),
('Bosko','Buha', '147-852', '1975-6-18',4,2),
('Marija','Marinic', '145-445', '1998-5-16',3,3),
('Ana','Anic', '969-006', '1996-2-12',2,3),
('Lucija','Lukovic', '177-231', '1994-2-1',5,4),
('Antea','Basic', '195-952', '1994-11-12',5,5)



insert into RoomTypes(Type, Description) VALUES
('Single','Room for one'),
('Double', 'Room for two'),
('Triple','Room for three'),
('King','Room with King-Size bed')


insert into Rooms(Number,Price,Capacity, HotelId, RoomTypeId) VALUES
(1,300,2,1,1),
(2,350,3,1,2),
(3,420,3,1,3),
(4,500,2,1,4),
(1,260,2,2,1),
(2,299.99,2,2,2),
(3,330,3,2,3),
(4,380,2,2,4),
(5,220,1,3,1),
(1,260,2,3,2),
(2,300,3,4,3),
(3,310,2,4,4),
(4,300,2,5,2)


insert into Customer(FirstName ,LastName,OIB,DateOfBirth,IsFrom) VALUES
('Marko','Markic', '123-456', '1992-6-12','Split'),
('Mike','Mikes', '453-126', '1990-2-23','Dubrovnik'),
('Ante','Antic', '656-456', '1986-9-1','Brac'),
('Bosko','Buha', '147-852', '1975-6-18','Zagreb'),
('Marija','Marinic', '145-445', '1998-5-16','Zagreb'),
('Ana','Anic', '969-006', '1996-2-12','Vinkovci'),
('Lucija','Lukovic', '177-231', '1994-2-1','Split'),
('Antea','Basic', '195-952', '1994-11-12','Split')


 insert into VisittingPeople(FirstName,LastName,OIB,DateOfBirth,Email) VALUES
 ('Ante','Antic','632-2364','1992-6-12','aAntic@Gmail.com'),
 ('Antea','Anticevic','192-2364','1994-3-12','aAnticevic@Gmail.com'),
 ('Matea','Antic','369-9856','1990-1-1','MAntic@Gmail.com'),
 ('Ivo','Ivic','784-2664','1989-6-12','iIvic@Gmail.com'),
 ('Luka','Lukic','125-2784','1999-6-12','lLukic@Gmail.com'),
 ('Mateo','Antic','415-3364','1996-5-2','mateo@Gmail.com'),
 ('Jure','Juric','547-9964','1969-6-12','Jure@Gmail.com'),
 ('Ante','Antunovic','142-9964','1989-6-12','Antun@Gmail.com'),
 ('Lucija','Lucic','632-9999','1991-6-12','LLucic@Gmail.com'),
 ('Antonija','Anonijic','111-2364','1993-6-12','Antonijaaa12@Gmail.com')


 insert into Reservations(DateOfArrival,DateOfDeparture,RoomId) values
('2019-12-25','2020-1-2',1),
('2020-1-4','2020-1-6',2),
('2020-1-6','2020-1-9',3),
('2020-1-8','2020-1-9',4),
('2020-1-10','2020-1-14',5),
('2020-1-12','2020-1-16',6),
('2020-2-2','2020-2-3',7),
('2020-2-4','2020-2-8',8),
('2020-2-6','2020-2-9',9),
('2020-2-8','2020-2-12',10),
('2020-2-10','2020-2-12',11),
('2020-2-12','2020-2-16',12)


insert into Purchase (DateOfPurchase, Price , CustomerId, PansionTypeId,ReservationsId) VALUES
('2019-9-22', 600,1,3,1),
('2020-2-12', 750,2,2,2),
('2020-3-15', 800,3,1,3),
('2020-4-17', 800,4,1,4),
('2021-5-23', 900,5,1,5),
('2021-6-1', 1200,6,1,6),
('2021-9-9', 250,7,3,7),
('2021-6-1', 1200,8,1,8)


insert into ReservationsVisittingPeople(VisittingPeopleId,ReservationId) VALUES
(1,1),
(2,2),
(3,2),
(4,2),
(3,3),
(4,4),
(6,5),
(7,6),
(6,7),
(9,8),
(2,9)


insert into Purchase (DateOfPurchase,Price,CustomerId,PansionTypeId,ReservationsId) values
('2020-1-1',400,1,3,1),
('2020-2-3',450,1,2,2),
('2020-3-4',520,2,2,3),
('2020-4-5',160,4,3,4),
('2020-5-6',900,5,1,5),
('2020-6-7',850,2,1,6),
('2020-1-8',630,4,1,7),
('2020-2-9',190,6,3,8),
('2020-3-10',885,7,1,9),
('2020-4-12',1500,8,1,10)


-------------------------------------------------1.
SELECT * FROM Rooms
WHERE HotelId IN (SELECT id FROM Hotels
	WHERE Name = 'Marmont'
);

-------------------------------------------------2.

SELECT * FROM	Rooms
WHERE CONVERT(varchar(20), Number) LIKE '1%'


-------------------------------------------------3.
SELECT FirstName, LastName FROM Staff
WHERE StaffWorkType IN (SELECT id FROM StaffWorkTypes
	WHERE Type = 'House keeping'
);


-------------------------------------------------4. 
SELECT * FROM Purchase
WHERE DateOfPurchase > '2020-1-12 0:0:0' AND Price > 1000


-------------------------------------------------5.

SELECT * FROM Reservations
WHERE DateOfArrival < GETDATE() AND DateOfDeparture > GETDATE()


-------------------------------------------------6.

DELETE FROM Reservations
WHERE id IN (SELECT ReservationsId FROM Purchase 
WHERE DateOfPurchase < '2020-1-1 0:0:0') 

DELETE FROM ReservationsVisittingPeople
WHERE ReservationId IN (SELECT ReservationsId FROM Purchase 
WHERE DateOfPurchase < '2020-1-1 0:0:0') 
    
	/* Ispisalo mi je neke greske ali mi je i napisao da je (1 row affected) */
-------------------------------------------------7.
select * FROM Rooms Where Capacity = 3

UPDATE Rooms
SET Capacity = 4
WHERE Capacity = 3 AND HotelId = 2

-------------------------------------------------8. 

SELECT * FROM Reservations
WHERE RoomId = 1
ORDER BY DateOfArrival 

-------------------------------------------------9.

SELECT * FROM Reservations
	WHERE id IN (SELECT ReservationsID FROM Purchase
		WHERE PansionTypeId < 3 ) AND RoomId IN (SELECT id FROM Rooms
			WHERE HotelId = 3)

-------------------------------------------------10.

UPDATE Staff
SET StaffWorkType = 5
WHERE StaffWorkType = 3 AND id = 11 OR id = 12


SELECT * FROM Staff
WHERE StaffWorkType = 5

