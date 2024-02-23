create database ikea;
use ikea;

CREATE TABLE Users(
user_id int auto_increment primary key,
username VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
password VARCHAR(255) NOT NULL,
registration_date timestamp default current_timestamp
);
select * from Users;
alter table Users rename to users;

CREATE TABLE products(
product_id int auto_increment primary key,
user_id int NOT NULL,
name VARCHAR(100) NOT NULL,
description text,
price float NOT NULL,
foreign key(user_id) references users(user_id)
);
select * from products;

CREATE TABLE user_wishlist(
wishlist_id int auto_increment primary key,
user_id int NOT NULL,
product_id int NOT NULL,
foreign key(user_id) references users(user_id),
foreign key(product_id) references products(product_id)
);
select * from user_wishlist;

CREATE TABLE user_reviews(
review_id int auto_increment primary key,
product_id int NOT NULL,
user_id int NOT NULL,
rating int NOT NULL,
review text,
review_date timestamp default current_timestamp,
foreign key(user_id) references users(user_id),
foreign key(product_id) references products(product_id)
);

alter table user_reviews rename to product_reviews;
select * from product_reviews;

insert into users(username, email, password)
values
('Robert', 'robert@yahoo.com', 'pass123'),
('John', 'john@yahoo.com', 'pass456'),
('Anna', 'anna@yahoo.com', 'pass2024'),
('George', 'george@yahoo.com', 'pass0000'),
('Carina', 'carina@yahoo.com', 'pass100'),
('Thomas', 'thomas@yahoo.com', 'pass78910'),
('David', 'david@gmail.com', 'pass203040');
select * from users;

insert into products(name, description, price)
values
('BRIMNES wardrobe', 'Small spaces need smart storage', '199'),
('PÄRUP sofa', 'Sleek design, quick assembly and easy-care with a removable and washable cover', '750'),
('EKENÄSET sofa', 'A slender and robust sofa inspired by 1950s Scandinavian design', '299'),
('HEMNES bookcase', 'Sustainable beauty from sustainably-sourced solid pine, a natural and renewable material', '199'),
('INGATORP table and 4 chairs', '4-seat dining set with a traditional look', '589'),
('KALLAX shelving unit', 'The KALLAX series adapts to taste, space, needs and budget', '50');
select * from products;

insert into product_reviews(product_id, user_id, rating, review)
values
('1', '2', '3', 'Average product, could be better'),
('1', '3', '5', 'Excellent'),
('2', '2', '5', 'Exceeded my expectations');
select * from product_reviews;

insert into user_wishlist(user_id, product_id)
values
('4','4'),
('4','3'),
('4','2'),
('1','4'),
('1','4');
select * from user_wishlist;

select * from users where username = 'Carina';
select name, price from products;

alter table products add manufacturer VARCHAR(50);
select * from products;

update  users set username = upper(username);
select username as 'USER' from users;

select * from product_reviews order by review desc;

delete from user_wishlist where user_id = 1;

select * from user_wishlist where product_id between 1 and 4;

-- Filtering with OR and AND operators
select * from users where username = 'Robert' and email = 'robert@yahoo.com';
select * from users where username = 'Robert' or username = 'Carina';

-- Filtering based on the LIKE operator
select * from users where username like '%na';
select * from users where username like '%n%';
select * from users where username like 'd%';

-- Instruction with aggregate functions
select count(*) from products;
select min(price) from products;
select sum(price) from products;
select sum(rating) from product_reviews;
select Avg(price) from products;

-- Tabels joins
select * from users left join product_reviews on users.user_id=product_reviews.review_id;
select *from users inner join user_wishlist on users.user_id=user_wishlist.wishlist_id;
