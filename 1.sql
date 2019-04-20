create database SostavBl;
show databases;

use SostavBl;

create table Ingred (
id_ingred int(6) not null auto_increment primary key,
unique u_ingred  (id_ingred),
name_ingred varchar(45) not null,
unique u_name  (name_ingred));

create table VidBl (
id_vidbl int(6) not null auto_increment primary key,
unique u_vidbl  (id_vidbl),
name_vidbl varchar(45) not null,
unique u_name  (id_vidbl));

create table Povar (
id_povar int(6) not null auto_increment primary key,
unique u_povar (id_povar),
name_povar varchar(60) not null,
pol char(1) not null,
date_of_birth date not null);

create table Price (
id_price int(6) not null auto_increment primary key,
unique u_price (id_price),
povar int(6)  not null,
foreign key (povar) references Povar(id_povar) on update cascade,
plusprice int(6)  not null,
price decimal(7,2) not null default '0.0');

create table Eat (
id_eat int(6) not null auto_increment primary key,
unique u_eat (id_eat),
name_eat varchar(45)  not null,
vid_eat int(6) not null,
foreign key (vid_eat) references VidBl(id_vidbl) on update cascade,
ves decimal(7,2) not null default '0.0',
povar int(6)  not null,
foreign key (povar) references Povar(id_povar) on update cascade,
price int(6)  not null,
foreign key (price) references Price(id_price) on update cascade);

create table Sostav (
id_sostav int(6) not null auto_increment primary key,
unique u_sostav (id_sostav),
ingred int(6)  not null,
foreign key (ingred) references Ingred(id_ingred) on update cascade,
val int(6) not null,
eat int(6)  not null,
foreign key (eat) references Eat(id_Eat) on update cascade);

insert into VidBl (name_vidbl) values
('суп'),
('закуска'),
('второе');

insert into Ingred (name_ingred) values
('ингредиент 1'),
('ингредиент 2'),
('ингредиент 3'),
('ингредиент 4');

insert into Povar (name_povar, pol, date_of_birth) values
('фио 1', 'м', '1985-7-14'),
('фио 2','м', '1986-7-14'),
('фио 3','м', '1987-7-14'),
('Петрова','ж', '1988-7-14'),
('Жук А.О.','ж', '1988-7-22');

insert into Price (povar, plusprice, price) values
(2, 120, 50.02),
(3, 100, 80.02),
(4, 50, 90.02),
(5, 50, 120.02),
(1, 200, 1500.02);


insert into Eat (name_eat, vid_eat, ves, povar, price) values
('суп 1', 1, 120.0, 2, 1),
('закуска 2', 2, 220.0, 4, 3),
('второе 3', 3, 120.0, 2, 1);

insert into Sostav (ingred, val, eat) values
(1, 1,2),
(2, 2,1),
(3, 1,1),
(1, 3,3),
(2, 4,3),
(3, 1,1),
(4, 1,3);


Select sum(ves) from Eat
inner join Povar on Eat.povar=Povar.id_povar 
where Povar.name_povar="Петрова";

select Eat.name_eat from Eat, Sostav, Price
where Sostav.val<4 and Price.plusprice in (select plusprice from Price where plusprice<50.0)
order by Eat.name_eat;

grant insert on SostavBl.Povar to 'user'@'localhost' identified by '123';
