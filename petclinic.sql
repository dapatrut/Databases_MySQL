/* DDL - it helps us define the types of data we add to the database
   DML - helps us to manage the entered data: insertion, editing, deletion
   DQL - it helps us to extract data from the database */

create database petclinic;
-- drop database petclinic -- stergere database; 

show databases;
select * from information_schema.tables;
select * from information_schema.views;
use petclinic;

-- Crearea unei tabele
CREATE TABLE owners (
    firstName VARCHAR(25) NOT NULL,
    lastName VARCHAR(25) NOT NULL
);

-- Adaugarea unei coloane intr-o tabela
alter table owners add column age int;

-- Stergerea unei coloane din tabela - doua instructiuni echivalente 
alter table owners drop column age;
alter table owners drop age;

-- Modify - poate sa modifice proprietatile unei coloane 
desc owners; -- arata structura tabelei
alter table owners modify firstName char(25) not null;
alter table owners modify lastName char(25) not null;

-- Instructiunea CHANGE – schimba numele unei coloane
alter table owners change lastName ownerLastName char(25) not null;

-- Instructiunea RENAME - schimba numele tabelei
alter table owners rename to petOwner;

/* Instructiunea de DROP TABLE sterge tabela impreuna cu toate informatiile */
-- drop table petOwner;

desc petOwner;
rename table petOwner to owners;
alter table owners change ownerLastName lastName varchar(25);

alter table owners add column dateOfBirth date;

-- Instructiunea INSERT - adaugam info noi in tab    
insert into owners (firstName, lastName, dateOfBirth)
values 
('Jim', 'Jameson', '1980-01-31'),
('Andrew', 'Smith', '1957-05-20'),
('Tom', 'Anderson', '1981-06-28');
select * from owners;        -- verificam rezultatele instructiunii de insert

-- update owners set firstName = 'James';
-- delete from owners;
-- truncate table owners;

-- Instructiunea SELECT - extragem info din BD in fct de anumite criterii
select firstName, lastName from owners; 
select firstName, dateOfBirth from owners; 

alter table owners
add column ageOwners VARCHAR(20) NOT NULL AFTER dateOfBirth;
select * from owners;

INSERT INTO owners(column4) 
VALUES ('30'), ('28'), ('39');

alter table owners drop column age;
alter table owners change ageOwners age varchar(25);

insert into owners (firstName, lastName, dateOfBirth, age)
values 
('Jack', 'Smith', '1983-02-18', 41);
insert into owners (firstName, lastName, dateOfBirth, age)
values 
('Robert', 'Deep', '1993-06-10', '25');
insert into owners (firstName, lastName, dateOfBirth, age)
values 
('Thomas', 'Cruise', '1984-05-25', '39');

-- Instructiunea WHERE - instructiune de filtrare 
select * from owners where dateOfBirth > '1970-12-31';
select * from owners where age > 29;
select * from owners where age < 41;
select * from owners where age = 41;
select * from owners where age >= 41;
select * from owners where age <= 41;

alter table owners add column city varchar(50);
update owners set city = 'Cluj' where firstName = 'Tom';
update owners set city = 'Cluj' where firstName = 'Andrew';
update owners set city = 'Bucuresti' where firstName = 'Jack';
update owners set city = 'Timisoara' where firstName = 'Jim';
update owners set age = '28' where firstName = 'Jim';
update owners set age = '45' where firstName = 'Andrew';
select * from owners;

select * from owners where firstName in ('Jim', 'Tom');    -- filtrare simpla, cu in
select * from owners where firstName not in ('Jim', 'Tom');
select * from owners where city is not null;
select * from owners where age != 41;                   -- != sau <>, exclude rezultatele
select * from owners where lastName != "Deep";
select * from owners where lastName <> "Deep";
select * from owners where age between 39 and 50;
select * from owners where firstName like 'T%';         -- filtrare pe baza operatorului LIKE
select * from owners where firstName like '%om';
select * from owners where firstName like '%d%';
select * from owners where dateOfBirth like '198%';    -- ii returneaza pe cei nascuti in anii 80`
select * from owners where dateOfBirth like '19%';
select * from owners where dateOfBirth like '%06%';
select * from owners where dateOfBirth like '%-06-%';   -- ii returneaza pe cei nascuti in luna 6-a

-- Filtrare cu operator AND si OR
select * from owners where firstName like '%om' and dateOfBirth like '198%'; 
select * from owners where firstName like '%om' or dateOfBirth like '198%'; 
select * from owners where (firstName like '%om' or dateOfBirth like '198%') and city = "Cluj";
select * from owners where firstName like '%om' or dateOfBirth like '198%' and city = "Cluj"; 

-- Instructiune cu functii agregate
select avg(age) from owners;
select sum(age) from owners;
select min(age) from owners;
select max(age) from owners;
select count(city) from owners;
select count(*) from owners;

-- Instructiune care contine clauza GROUP BY
select firstName, lastName, min(age) from owners
group by firstName, lastName;
select * from owners;

insert into owners (firstName, lastName, dateOfBirth, age)
values ('Winston', 'Churchill', '1898-06-06', 47);
update owners set dateOfBirth = "1898-05-06" where firstName = "Winston";

-- Creare cheie primara
alter table owners add column ownerId int primary key auto_increment;
alter table owners modify column ownerId int auto_increment first;
desc owners;

insert into owners (firstName, lastName, dateOfBirth, age)
values ('Anton', 'Pann', '1823-04-17', '95');
insert into owners (firstName, lastName, dateOfBirth, age)
values ('Anton', 'Pann', '1823-04-17', '95');

create table pets (
petid int not null auto_increment,
race varchar(45) not null,
dateOfBirth date not null,
ownerId int not null,
primary key (petid),
constraint fk_pets_owners foreign key (ownerid) references owners(ownerid)  -- cheie secundara
);

insert into pets (race, dateOfBirth, ownerId)
value ('european', '2020-02-15', 8);
insert into pets (race, dateOfBirth, ownerId)
value ('spitz', '2021-12-07', 6);

delete from owners where ownerId = 10;
delete from pets where ownerid = 10;

select * from owners;
select * from pets;

-- Tabels joins
select * from owners cross join pets;
select * from owners cross join pets on owners.ownerid = pets.ownerId;
select * from owners inner join pets on owners.ownerid = pets.ownerId;
select * from owners left join pets on owners.ownerid = pets.ownerId;
select * from owners left join pets on owners.ownerid = pets.ownerId where pets.ownerId is not null;
select * from owners right join pets on owners.ownerid = pets.ownerId;
select * from owners right join pets on owners.ownerid = pets.ownerId where pets.ownerId is null;
select * from owners right join pets on owners.ownerid = pets.ownerId where pets.ownerId is not null;




