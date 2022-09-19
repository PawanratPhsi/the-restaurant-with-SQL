
-- Creating Database for Restaurant using SQL
-- As the restaurant has many branches in different cities, owner would like to collect data in database. 
-- I will design a database consisting of seven tables as follows: 
-- 1.Type Menu        : Catagorize menu into five groups including with soup, salad, main, pizza and beverage.  
-- 2.Menu             : Describe menu name and price. 
-- 3.Location Branch  : Specify five cities that locate restaurants 
-- 4.Employee         : Enclose employee name, position, salary and branch 
-- 5.Customer         : Include customer name, membership, history scores 
-- 6.Payment Term     : Have cash and credit card for payment
-- 7.Orders           : Contain service history of customers 


-- Table 1 : Type Menu 
CREATE TABLE type_menu(
    type_id INT UNIQUE,
    type_name TEXT,
    PRIMARY KEY(type_id)
);

INSERT INTO type_menu VALUES
    (1,"Soup"),
    (2,"Salad"),
    (3,"Main"),
    (4,"Pizza"),
    (5,"Beverage");

-- Table 2 : Menu
CREATE TABLE menu(
    menu_id INT,
    menu_name TEXT,
    menu_price INT,
    type_id INT,
    PRIMARY KEY(menu_id),
    FOREIGN KEY(type_id) REFERENCES type_menu(type_id)
);

INSERT INTO menu VALUES
(1, "Pumpkin Truffle Soup", 150, 1),
(2, "Mushroom Soup", 120, 1),
(3, "Chinken Caesar Salad", 200, 2),
(4, "Spicy Caesar Salad", 180, 2),
(5, "Tokyo Salad", 200, 2),
(6, "Creamy Salmon Pasta", 190, 3),
(7, "Tomyum Seafood Spaghetti", 300, 3),
(8, "Okinawa Rich Bowl", 250, 3),
(9, "Salmon Pesto", 220, 3),
(10, "Beef Fried Rice", 180, 3),
(11, "Spicy Seafood Pizza", 460, 4),
(12, "Hawaiian Pizza", 300, 4),
(13, "Pepperoni Pizza", 320, 4),
(14, "Salmon Cream Cheese Pizza", 420, 4),
(15, "Marghrita Pizza", 350, 4),
(16, "Americano", 90, 5),
(17, "Chocolate", 120, 5),
(18, "Tea", 70, 5),
(19, "Orange Juice", 100, 5),
(20, "Strawberry Soda", 80, 5);

-- Table 3 : Location 
CREATE TABLE location(
    location_id INT UNIQUE,
    city TEXT,
    delivery BOOLEAN,
    PRIMARY KEY(location_id)
);

INSERT INTO location VALUES
(1, "Bangkok", 1),
(2, "London", 0),
(3, "Tokyo", 1),
(4, "Singapore", 1),
(5, "Paris", 0);

-- Table 4 : Employee 
CREATE TABLE employee(
    employee_id INT UNIQUE,
    employee_name TEXT,
    position TEXT,
    salary INT,
    location_id INT,
    PRIMARY KEY(employee_id),
    FOREIGN KEY(location_id) REFERENCES location(location_id)
);

INSERT INTO employee VALUES
(1, "Top", "Manager", 35000, 1),
(2, "Mali", "Chef", 40000, 1),
(3, "Beer", "Staff", 25000, 1),
(4, "Rose", "Chef", 90000, 2),
(5, "Marry", "Manager", 120000, 2),
(6, "Emma", "Staff", 40000, 2),
(7, "Nana", "Staff", 30000, 3),
(8, "Cho", "Chef", 60000, 3),
(9, "Yoko", "Manager", 80000, 3),
(10, "Mike", "Staff", 35000, 4),
(11, "Gift", "Manager", 95000, 4),
(12, "Four", "Chef", 65000, 4),
(13, "Sara", "Manager", 100000, 5),
(14, "Harper", "Chef", 80000, 5), 
(15, "Alice", "Staff", 40000, 5);

-- Table 5 : Customer 
CREATE TABLE customer(
  customer_id INT UNIQUE,
  customer_name TEXT,
  member BOOL,
  score INT,
  location_id INT,
  PRIMAry KEY(customer_id),
  FOREIGN KEY(location_id) REFERENCES location(location_id)
  );
  
INSERT INTO customer VALUES
(1, "Aoi", 1, 3745, 3),
(2, "Bara", 1, 1213, 3),
(3, "Chiki", 0, 0, 3),
(4, "Daiki", 1, 545, 3),
(5, "Fuji", 1, 4978, 3),
(6, "Hachi", 0, 0, 3),
(7, "Manop", 0, 0, 1),
(8, "Dao", 1, 2437, 1),
(9, "Chompo", 0, 0, 1),
(10, "Praew", 0, 0, 1),
(11, "Kaew", 0, 0, 1),
(12, "Montra", 1, 1081, 1),
(13, "Gaston", 1, 7025, 2),
(14, "Dion", 1, 11875, 2),
(15, "Cosmo", 1, 4321, 2),
(16, "Niko", 1, 278, 2),
(17, "Bastien", 1, 9872, 2),
(18, "Armando", 0, 0, 2),
(19, "Pascal", 1, 5879, 5),
(20, "Sven", 1, 10121, 5),
(21, "Zeno", 0, 0, 5),
(22, "Anthony", 0, 0, 5),
(23, "Ryker", 1, 1246, 5),
(24, "Chloe", 1, 8746, 4),
(26, "Mikayla", 1, 117, 4),
(27, "Olivia", 0, 0, 4),
(28, "Leia", 0, 0, 4),
(29, "Micky", 1, 6758, 4),
(30, "David", 1, 832, 4);

-- Table 6 : Payment term 
CREATE TABLE payment(
    payment_id INT UNIQUE,
    payment_term TEXT,
    PRIMARY KEY(payment_id)
);

INSERT INTO payment VALUES
(1, "Cash"),
(2, "Credit Card");

-- Table 7 : Order 
CREATE TABLE orders(
    order_id INT UNIQUE,
    order_date DATETIME,
    menu_id INT,
    customer_id INT,
    location_id INT,
    payment_id INT,
    total_price INT,
    PRIMARY KEY(order_id),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(location_id) REFERENCES location(location_id),
    FOREIGN KEY(payment_id) REFERENCES payment(payment_id)     
);

INSERT INTO orders VALUES
(1, "2022-08-01 18:30:05", 12, 14, 2, 1, 300),
(2, "2022-08-01 18:50:15", 16, 20, 5, 1, 90),
(3, "2022-08-01 19:20:24", 2, 25, 4, 1, 120),
(4, "2022-08-01 20:00:50", 9, 29, 4, 1, 220),
(5, "2022-08-02 18:50:23", 14, 8, 1, 2, 420),
(6, "2022-08-02 19:15:17", 14, 2, 3, 2, 420),
(7, "2022-08-02 20:00:58", 17, 13, 2, 1, 120),
(8, "2022-08-02 20:20:01", 18, 28, 4, 1, 70),
(9, "2022-08-03 18:15:07", 1, 12, 1, 1, 150),
(10, "2022-08-03 18:30:12", 4, 12, 1, 1, 180),
(11, "2022-08-03 19:10:11", 11, 15, 2, 2, 460),
(12, "2022-08-03 20:15:25", 19, 14, 2, 1, 100),
(13, "2022-08-03 20:45:11", 5, 4, 3, 1, 200),
(14, "2022-08-04 18:30:55", 14, 19, 5, 1, 420),
(15, "2022-08-04 18:55:17", 10, 24, 5, 1, 180),
(16, "2022-08-04 19:20:48", 3, 17, 2, 1, 200),
(17, "2022-08-04 20:17:15", 13, 16, 2, 2, 320),
(18, "2022-08-05 18:30:00", 14, 1, 3, 2, 420),
(19, "2022-08-05 18:30:59", 5, 4, 3, 1, 200),
(20, "2022-08-05 18:45:04", 15, 30, 4, 2, 350),
(21, "2022-08-05 19:00:10", 7, 3, 3, 2, 300),
(22, "2022-08-05 19:10:49", 20, 11, 1, 1, 80),
(23, "2022-08-05 19:22:37", 6, 20, 5, 1, 190),
(24, "2022-08-05 19:45:28", 17, 7, 1, 1, 120),
(25, "2022-08-05 19:45:28", 19, 7, 1, 1, 100),
(26, "2022-08-05 20:15:11", 9, 18, 2, 1, 220),
(27, "2022-08-05 20:35:19", 12, 14, 2, 2, 300),
(28, "2022-08-05 20:50:15", 2, 3, 3, 1, 150),
(29, "2022-08-06 18:30:02", 12, 6, 3, 2, 300),
(30, "2022-08-06 18:35:17", 11, 10, 1, 1, 460),
(31, "2022-08-06 18:50:22", 15, 21, 5, 2, 350),
(32, "2022-08-06 19:20:19", 1, 9, 1, 1, 150),
(33, "2022-08-06 19:45:46", 19, 28, 4, 1, 100),
(34, "2022-08-06 20:11:54", 5, 5, 3, 1, 200),
(35, "2022-08-06 20:29:14", 14, 5, 3, 2, 420),
(36, "2022-08-07 18:30:01", 11, 14, 2, 2, 460),
(37, "2022-08-07 18:33:59", 16, 17, 2, 1, 90),
(38, "2022-08-07 19:00:12", 14, 17, 2, 1, 420),
(39, "2022-08-07 19:05:23", 5, 21, 5, 1, 200),
(40, "2022-08-07 19:48:17", 20, 30, 4, 1, 80),
(41, "2022-08-08 18:15:12", 18, 29, 4, 1, 70),
(42, "2022-08-08 18:30:11", 13, 20, 5, 2, 320),
(43, "2022-08-08 19:58:52", 11, 5, 3, 2, 460),
(44, "2022-08-09 18:08:11", 5, 12, 1, 1, 200),
(45, "2022-08-09 18:45:34", 14, 15, 2, 2, 420),
(46, "2022-08-09 20:30:38", 8, 16, 2, 1, 250),
(47, "2022-08-10 18:30:11", 12, 3, 3, 1, 300),
(48, "2022-08-10 19:14:12", 6, 5, 3, 1, 190),
(49, "2022-08-10 19:39:45", 11, 5, 3, 2, 460),
(50, "2022-08-11 18:11:58", 17, 19, 5, 1, 120),
(51, "2022-08-11 18:32:15", 14, 14, 2, 2, 420),
(52, "2022-08-11 20:20:21", 13, 17, 2, 1, 320),
(53, "2022-08-12 18:11:11", 14, 29, 4, 2, 420),
(54, "2022-08-12 18:30:01", 16, 29, 4, 1, 90),
(55, "2022-08-12 18:30:38", 11, 8, 1, 2, 460),
(56, "2022-08-12 19:12:09", 14, 12, 1, 1, 420),
(57, "2022-08-12 19:31:18", 1, 10, 1, 1, 150),
(58, "2022-08-12 19:55:36", 3, 20, 5, 1, 200),
(59, "2022-08-12 20:18:06", 7, 8, 1, 1, 300),
(60, "2022-08-12 20:34:12", 7, 11, 1, 1, 300),
(61, "2022-08-12 20:39:54", 12, 23, 5, 1, 320),
(62, "2022-08-12 20:48:12", 7, 14, 2, 1, 300),
(63, "2022-08-12 20:58:45", 14, 13, 2, 2, 420),
(64, "2022-08-13 18:09:11", 11, 24, 5, 2, 460),
(65, "2022-08-13 18:30:59", 19, 16, 2, 1, 100),
(66, "2022-08-13 18:59:14", 10, 19, 5, 1, 180),
(67, "2022-08-13 19:45:49", 5, 15, 2, 1, 200),
(68, "2022-08-13 20:37:16", 3, 14, 2, 1, 200),
(69, "2022-08-14 18:30:25", 14, 20, 5, 2, 420),
(70, "2022-08-14 19:47:31", 7, 25, 4, 1, 300);





