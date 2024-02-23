-- Create a database named ‘computerstore'
create database computerstore; 
use computerstore;

-- Create the tables 
create table Manufactures(
Code int auto_increment primary key NOT NULL,
Name VARCHAR(50) NOT NULL
);
alter table Manufactures rename to Manufacturers;
select * from Manufacturers;

create table Products(
Code int auto_increment primary key NOT NULL,
Name VARCHAR(50) NOT NULL,
Price float NOT NULL,
Manufacturer int  NOT NULL,
constraint fk_Manufacturers foreign key (Manufacturer) references Manufacturers(Code)
);
select * from Products;

-- Insert the data into the tables
insert into Manufacturers (Code, Name)
values ('1','Sony'), ('2', 'Asus'), ('3', 'Hewlett-Packard'), ('4', 'Lenovo'), ('5', 'Fujitsu'), ('6', 'SanDisk');

insert into Products (Code, Name, Price, Manufacturer)
values
('1', 'Hard Drive', '64.89', '5'),
('2', 'Memory Card', '17.99', '6'),
('3', 'Laptop charger', '42.29', '4'),
('4', 'USB Flash drive', '10', '6'),
('5', 'Monitor', '219.99', '1');

insert into Products (Code, Name, Price, Manufacturer)
values
('6', 'HDMI cable', '18.29', '2'),
('7', 'Gaming laptop', '2079.59', '2'),
('8', 'Printer','96.32', '3'),
('9', 'Toner cartridge', '59', '3'),
('10', 'Computer case','158.92', '2');
select * from Products;

-- Check that all the records were inserted in the Manufacturers table
select * from Manufacturers;

-- Select the names of all the products in the store. 
select name from Products;

-- Select the names and the prices of all the products in the store. 
select name, price from Products;

-- Select the name of the products with a price less than or equal to $200 
select name from Products where price <= 200;

-- Select all the products with a price between $60 and $120 
select * from Products where price between 60 and 120;

-- Select the name and price in cents (i.e., the price must be multiplied by 100). 
select name, price * 100 from Products;

-- Compute the average price of all the products 
select avg(price) from Products;

-- Compute the average price of all products where the manufacturer is Asus 
desc Manufacturers;
select avg(price) from Products where Manufacturer=(select Code from Manufacturers where
name = 'Asus');
-- se mai poate rezolva si cu inner join, aduceam din ambele tab si puneam conditie
select avg(price) from products
inner join manufacturers on manufacturers.Code=products.Manufacturer where
manufacturers.name='Asus';

-- Compute the average price of all products with manufacturer code equal to 2.
select avg(Price) from Products where Manufacturer=2;

-- Compute the number of products with a price larger than or equal to $180
select count(*) from Products where price >= 180; 
--  count(*), merge si cu count(code)

/*  Select the name and price of all products with a price larger than or equal to $180, and
sort first by price (in descending order), and then by name (in ascending order) */
select name, price from Products where price >= 180 order by price desc, name asc;

-- Select all the data from the products, including all the data for each product's manufacturer 
select * from Products left join Manufacturers on Products.Manufacturer = Manufacturers.Code;

-- Select the product name, price, and manufacturer name of all the products 
select Products.Name, Products.Price, Manufacturers.Name from Products left join Manufacturers on Products.Manufacturer = Manufacturers.Code;   
-- price se poate pune si fara numele tab, nu il avem in ambele tab
-- se poate folosi si inner join

-- Select the average price of each manufacturer's products, showing only the manufacturer's code 
select avg(price), Manufacturer from Products group by Manufacturer;

-- Select the average price of each manufacturer's products, showing the manufacturer's name
SELECT AVG(Price), Manufacturers.Name
FROM Products INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name;

-- Select the name and price of the cheapest product using MIN with a nested select.
SELECT Name, Price
FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);

-- Ordering and limiting to 1 
SELECT Name, Price
FROM Products
ORDER BY Price ASC
LIMIT 1;

-- Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products (Code, Name, Price, Manufacturer)
VALUES (11, 'Loudspeakers', 70, 2);
SELECT * FROM Products WHERE Code = 11;

-- Update the name of product 8 to "Laser Printer".
SELECT * FROM Products WHERE Code = 8;
UPDATE Products 
SET Name = 'Laser printer'
WHERE Code = 8;

-- Apply a 10% discount to all products.
UPDATE Products
SET Price = Price - (Price * 0.1);

-- Apply a 15% discount to all products with a price larger than or equal to $120.
Select price-(0.15*price) discount15, code, name, manufacturer, price from products
where price >= 120;

-- Select the product with the smallest price where the manufacturer is Sony.
SELECT MIN(Price)
FROM Products
WHERE Manufacturer = (SELECT Code FROM Manufacturers WHERE Name = 'Asus');

SELECT MIN(Price)
FROM Products INNER JOIN Manufacturers
ON Manufacturers.Code = Products.Manufacturer
WHERE Manufacturers.Name = 'Asus';

--  Select all products where manufacturers are Sony, Asus and Lenovo.
SELECT * FROM Products
WHERE Manufacturer IN (SELECT Code FROM manufacturers WHERE Name IN ('Sony', 'Lenovo', 'Asus'));
SELECT Code FROM manufacturers WHERE Name IN ('Sony', 'Lenovo', 'Asus');

SELECT * FROM Products
WHERE Price IN (63, 16.461);

SELECT * FROM Products;

SELECT * FROM Products
WHERE Name IN ('Laser printer', 'Gaming Laptop', 'Monitor');

SELECT * FROM Products
WHERE Name = 'Laser Printer' OR Name = 'Gaming Laptop' OR Name = 'Monitor';
