CREATE DATABASE AutoWashProDB;
GO

USE AutoWashProDB;
GO

/* =========================================================
   1. CUSTOMER TIERS
========================================================= */

CREATE TABLE CustomerTiers
(
    TierID INT PRIMARY KEY IDENTITY(1,1),

    TierName NVARCHAR(50) NOT NULL UNIQUE,

    MinBookings INT DEFAULT 0,

    MinSpend DECIMAL(12,2) DEFAULT 0,

    PointMultiplier DECIMAL(5,2) DEFAULT 1.0,

    DiscountPercent DECIMAL(5,2) DEFAULT 0,

    PriorityLevel INT DEFAULT 1,

    BookingWindowDays INT DEFAULT 7,

    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

/* =========================================================
   2. CUSTOMERS
========================================================= */

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY IDENTITY(1,1),

    FullName NVARCHAR(100) NOT NULL,

    PhoneNumber NVARCHAR(20) NOT NULL UNIQUE,

    Email NVARCHAR(100) NOT NULL UNIQUE,

    PasswordHash NVARCHAR(255) NOT NULL,

    Address NVARCHAR(255),

    TierID INT DEFAULT 1,

    CurrentPoints INT DEFAULT 0,

    TotalBookings INT DEFAULT 0,

    TotalSpend DECIMAL(12,2) DEFAULT 0,

    Status BIT DEFAULT 1,

    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Customers_Tiers
        FOREIGN KEY (TierID)
        REFERENCES CustomerTiers(TierID)
);
GO

/* =========================================================
   3. VEHICLES
========================================================= */

CREATE TABLE Vehicles
(
    VehicleID INT PRIMARY KEY IDENTITY(1,1),

    CustomerID INT NOT NULL,

    LicensePlate NVARCHAR(20) NOT NULL UNIQUE,

    Brand NVARCHAR(50),

    Model NVARCHAR(50),

    Color NVARCHAR(30),

    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Vehicles_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
GO

/* =========================================================
   4. BOOKINGS
========================================================= */

CREATE TABLE Bookings
(
    BookingID INT PRIMARY KEY IDENTITY(1,1),

    VehicleID INT NOT NULL,

    BookingDate DATETIME NOT NULL,

    ServiceType NVARCHAR(100) NOT NULL,

    BookingStatus NVARCHAR(20)
        DEFAULT 'Pending'
        CHECK (BookingStatus IN
        (
            'Pending',
            'Confirmed',
            'Completed',
            'Cancelled'
        )),

    Notes NVARCHAR(255),

    TotalAmount DECIMAL(12,2) DEFAULT 0,

    DiscountAmount DECIMAL(12,2) DEFAULT 0,

    FinalAmount DECIMAL(12,2) DEFAULT 0,

    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Bookings_Vehicles
        FOREIGN KEY (VehicleID)
        REFERENCES Vehicles(VehicleID)
);
GO

/* =========================================================
   5. POINT TRANSACTIONS
========================================================= */

CREATE TABLE PointTransactions
(
    PointTransactionID INT PRIMARY KEY IDENTITY(1,1),

    CustomerID INT NOT NULL,

    BookingID INT NULL,

    PointsChanged INT NOT NULL,

    TransactionType NVARCHAR(20)
        CHECK (TransactionType IN
        (
            'EARN',
            'REDEEM',
            'EXPIRE',
            'BONUS'
        )),

    ExpiryDate DATETIME NULL,

    Description NVARCHAR(255),

    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_PointTransactions_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_PointTransactions_Bookings
        FOREIGN KEY (BookingID)
        REFERENCES Bookings(BookingID)
);
GO

/* =========================================================
   INSERT DEFAULT CUSTOMER TIERS
========================================================= */

INSERT INTO CustomerTiers
(
    TierName,
    MinBookings,
    MinSpend,
    PointMultiplier,
    DiscountPercent,
    PriorityLevel,
    BookingWindowDays
)
VALUES
('Member', 0, 0, 1.0, 0, 1, 7),
('Silver', 5, 2000000, 1.1, 5, 2, 10),
('Gold', 15, 6000000, 1.2, 10, 3, 12),
('Platinum', 30, 15000000, 1.3, 15, 4, 14);
GO

/* =========================================================
   INSERT CUSTOMERS
========================================================= */

INSERT INTO Customers
(
    FullName,
    PhoneNumber,
    Email,
    PasswordHash,
    Address,
    TierID,
    CurrentPoints,
    TotalBookings,
    TotalSpend
)
VALUES
(
    'Nguyen Van A',
    '0901234567',
    'vana@gmail.com',
    'HASHED_PASSWORD_1',
    'Ho Chi Minh City',
    1,
    120,
    2,
    350000
),
(
    'Tran Thi B',
    '0912345678',
    'thib@gmail.com',
    'HASHED_PASSWORD_2',
    'Da Nang',
    2,
    580,
    8,
    2500000
),
(
    'Le Van C',
    '0988888888',
    'vanc@gmail.com',
    'HASHED_PASSWORD_3',
    'Ha Noi',
    3,
    1400,
    20,
    7500000
);
GO

/* =========================================================
   INSERT VEHICLES
========================================================= */

INSERT INTO Vehicles
(
    CustomerID,
    LicensePlate,
    Brand,
    Model,
    Color
)
VALUES
(1, '51A-12345', 'Toyota', 'Vios', 'White'),
(1, '51G-67890', 'Honda', 'City', 'Black'),
(2, '43A-99999', 'Mazda', 'CX5', 'Red'),
(3, '30H-45678', 'Hyundai', 'Elantra', 'Blue');
GO

/* =========================================================
   INSERT BOOKINGS
========================================================= */

INSERT INTO Bookings
(
    VehicleID,
    BookingDate,
    ServiceType,
    BookingStatus,
    Notes,
    TotalAmount,
    DiscountAmount,
    FinalAmount
)
VALUES
(
    1,
    '2026-05-20 08:00:00',
    'Premium Wash',
    'Completed',
    'VIP customer',
    200000,
    10000,
    190000
),
(
    2,
    '2026-05-22 10:30:00',
    'Interior Cleaning',
    'Pending',
    NULL,
    300000,
    0,
    300000
),
(
    3,
    '2026-05-23 14:00:00',
    'Wax Coating',
    'Confirmed',
    'Customer requests fast service',
    500000,
    25000,
    475000
),
(
    4,
    '2026-05-24 09:00:00',
    'Basic Wash',
    'Completed',
    NULL,
    100000,
    0,
    100000
);
GO

/* =========================================================
   INSERT POINT TRANSACTIONS
========================================================= */

INSERT INTO PointTransactions
(
    CustomerID,
    BookingID,
    PointsChanged,
    TransactionType,
    ExpiryDate,
    Description
)
VALUES
(
    1,
    1,
    190,
    'EARN',
    DATEADD(MONTH, 12, GETDATE()),
    'Earned points from Premium Wash'
),
(
    2,
    3,
    475,
    'EARN',
    DATEADD(MONTH, 12, GETDATE()),
    'Earned points from Wax Coating'
),
(
    2,
    NULL,
    -200,
    'REDEEM',
    NULL,
    'Redeemed points for discount voucher'
),
(
    3,
    4,
    100,
    'BONUS',
    DATEADD(MONTH, 12, GETDATE()),
    'Gold member bonus points'
);
GO

/* =========================================================
   INDEXES
========================================================= */

CREATE INDEX IDX_Vehicles_LicensePlate
ON Vehicles(LicensePlate);

CREATE INDEX IDX_Bookings_Date
ON Bookings(BookingDate);

CREATE INDEX IDX_PointTransactions_CustomerID
ON PointTransactions(CustomerID);

CREATE INDEX IDX_Customers_Phone
ON Customers(PhoneNumber);
GO

/* =========================================================
   SAMPLE QUERY 1
   VIEW CUSTOMER + TIER
========================================================= */

SELECT
    C.CustomerID,
    C.FullName,
    C.PhoneNumber,
    T.TierName,
    C.CurrentPoints,
    C.TotalSpend
FROM Customers C
JOIN CustomerTiers T
    ON C.TierID = T.TierID;
GO

/* =========================================================
   SAMPLE QUERY 2
   VIEW VEHICLES OF CUSTOMERS
========================================================= */

SELECT
    C.FullName,
    V.LicensePlate,
    V.Brand,
    V.Model,
    V.Color
FROM Vehicles V
JOIN Customers C
    ON V.CustomerID = C.CustomerID;
GO

/* =========================================================
   SAMPLE QUERY 3
   VIEW BOOKING HISTORY
========================================================= */

SELECT
    B.BookingID,
    C.FullName,
    V.LicensePlate,
    B.ServiceType,
    B.BookingDate,
    B.BookingStatus,
    B.FinalAmount
FROM Bookings B
JOIN Vehicles V
    ON B.VehicleID = V.VehicleID
JOIN Customers C
    ON V.CustomerID = C.CustomerID
ORDER BY B.BookingDate DESC;
GO

/* =========================================================
   SAMPLE QUERY 4
   VIEW POINT TRANSACTIONS
========================================================= */

SELECT
    PT.PointTransactionID,
    C.FullName,
    PT.PointsChanged,
    PT.TransactionType,
    PT.Description,
    PT.CreatedAt
FROM PointTransactions PT
JOIN Customers C
    ON PT.CustomerID = C.CustomerID
ORDER BY PT.CreatedAt DESC;
GO