create database aircargo;
use aircargo;

drop table if exists customer;
create table if not exists customer(
customer_id int,
first_name varchar(100) not null,
last_name varchar(100) default null,
dob char(10) not null,
gender varchar(2),
primary key(customer_id)
);
describe table customer;
CREATE TABLE pof (
  customer_id int NOT NULL,
  aircraft_id varchar(100) NOT NULL,
  route_id int NOT NULL,
  depart varchar(3) NOT NULL,
  arrival varchar(3) NOT NULL,
  seat_num varchar(10) DEFAULT NULL,
  class_id varchar(100) DEFAULT NULL,
  travel_date char(10) DEFAULT NULL,
  flight_num int NOT NULL,
  KEY customer_id (customer_id),
  KEY route (route_id),
  CONSTRAINT pof_fk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  CONSTRAINT pof_fk_2 FOREIGN KEY (route_id) REFERENCES routes (route_id) 
);

CREATE TABLE routes (
  route_id int NOT NULL,
  flight_num int NOT NULL,
  origin_airport varchar(3) NOT NULL,
  destination_airport varchar(100) NOT NULL,
  aircraft_id varchar(100) NOT NULL,
  distance_miles int NOT NULL,
  PRIMARY KEY (route_id),
  CONSTRAINT Flight_number_check CHECK ((substr(flight_num,1,2) = 11)),
  CONSTRAINT routes_chk_1 CHECK ((distance_miles > 0))
);
desc routes;
CREATE TABLE ticket_details (
  p_date char(10) NOT NULL,
  customer_id int NOT NULL,
  aircraft_id varchar(100) NOT NULL,
  class_id varchar(100) DEFAULT NULL,
  no_of_tickets int DEFAULT NULL,
  a_code varchar(3) DEFAULT NULL,
  Price_per_ticket int DEFAULT NULL,
  brand varchar(100) DEFAULT NULL,
  KEY customer_id (customer_id),
  CONSTRAINT ticket_details_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);
-- Query 3 
select * from pof
where route_id between 1 and 25
order by customer_id;

-- Query 4
select if(grouping (class_id),'Total',class_id) as class,
Count(*)as Total_passenger , sum(no_of_tickets * Price_per_ticket) as Total_Revenue from ticket_details
group by class_id with rollup
order by Total_Revenue;

-- Query 5
select concat(first_name, ' ', last_name) as Name from customer
order by name;

-- Query 6
select c.customer_id , concat(c.first_name, ' ' , c.last_name) as Name, count(t.no_of_tickets) as Total_Tickets_booked
from customer c
join ticket_details t using (customer_id)
group by c.customer_id, Name
order by Total_tickets_booked desc;

-- Query 7
select c.customer_id, c.first_name, c.last_name
from customer c
join ticket_details t using (customer_id)
where brand = 'Emirates' 
order by c.customer_id;

-- Query 8
select c.customer_id, c.first_name, c.last_name , p.class_id
from customer c
join pof p using(customer_id)
group by c.customer_id
having p.class_id ='Economy plus'
order by c.customer_id;

-- Query 9 
select if(sum(no_of_tickets*price_per_ticket)>10000 , 'Revenue crossed 10000', 'Revenue is less then 10000') as Revenue_status
from ticket_details;

-- Query 10
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT, INSERT, UPDATE, DELETE ON aircargo.*  TO 'new_user'@'localhost';

-- Query 11
with ctc as (select class_id,price_per_ticket as max_price_per_ticket ,
rank() over (partition by class_id order by price_per_ticket desc) as Rank_ticket from ticket_details)
select distinct * from ctc where Rank_ticket =1;

-- Query 12
SELECT p.customer_id,c.first_name,c.last_name FROM pof p 
left join  customer c 
on p.customer_id = c.customer_id
where route_id = 4;

-- Query 13
SELECT * FROM pof
WHERE route_id = 4;

-- Query 14
select sum(no_of_tickets*price_per_ticket) as Total_Price, aircraft_id
from ticket_details
group by aircraft_id with rollup;

-- Query 15
drop view  if exists Brand;
create view Brand as 
SELECT c.customer_id, c.first_name, c.last_name , t.brand, t.class_id
FROM customer c
JOIN ticket_details t USING (customer_id)
WHERE t.class_id = 'Bussiness'
ORDER BY c.customer_id;

-- Query 16
DELIMITER $$
create procedure route (in route_id1 int,  in route_id2 int)
BEGIN 
declare continue handler for sqlstate '42S02'
begin 
select 'No records available ' as Message;
end;
select rd.route_id, pd.customer_id, c.first_name,c.last_name 
from routes rd
inner join pod pd
on rd.route_id = pd.route_id
left join customer c 
using (customer_id)
where rd.route_id between route_id1 and route_id2;

select * from routes;
end$$
DELIMITER ;
CALL route(4,7);

-- Query 17
drop procedure if exists distance;
delimiter //
create procedure distance( in miles int)
begin
select * from routes
where distance_miles >miles
order by distance_miles;
end//
delimiter ;

call distance(2000);

-- Query 18 
drop procedure if exists distancegrouping; 
delimiter &&
create procedure distancegrouping(in flight_num1 int)
Begin
select * ,
case
when distance_miles>=0 and distance_miles<=2000 then "Short distance"
when distance_miles>=2000 and distance_miles<=6500 then "Intermediate Distance"
else 'Long Distance'
end as category
from routes
where flight_num = flight_num1;
end&&
delimiter ;
call distancegrouping(1119);

-- Query 19
drop procedure if exists complementry_service;
delimiter %%
create procedure complementry_service(in customer_id1 int)
begin 
select p_date, class_id,customer_id,
case
when class_id= 'Bussiness' or  class_id = 'Economy Plus' then 'Complementry Services '
else 'No Complementry Services'
end as Service_distribution
from ticket_details
where customer_id= customer_id1;
end %%
delimiter ;
call complementry_service(8);


-- Query 20
delimiter $$
create procedure firstrecord()
begin
declare a varchar(20);
declare b varchar(20);
declare c int;
declare cursor_1 cursor for select first_name, last_name,customer_id from customer
where last_name='Scott';
open cursor_1;
fetch cursor_1 into a,b,c;
select a as first_name, b as last_name , c as customer_id;
close cursor_1;
end$$
delimiter ;
call firstrecord();



















