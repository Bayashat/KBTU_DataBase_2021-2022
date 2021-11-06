1-Exersice
-- a
select * from dealer inner join client
    on dealer.id = client.dealer_id;
-- b
select  client.name,client.city,client.priority,sell.id, sell.amount,sell.date from client inner join sell
   on sell.dealer_id = client.dealer_id;
--c
select  dealer.name as dealer,client.name,client.city from dealer inner join  client on dealer.location = client.city
--d
select sell.id,sell.amount,client.name, client.city from sell inner join  client on
    sell.amount >= 100 and sell.amount <= 500 and client.id = sell.client_id;
--e
select dealer.id, dealer.name from dealer left outer join client on client.dealer_id = dealer.id
--f
select dealer.name,client.name,client.city, dealer.charge from dealer inner join client on dealer.id = client.dealer_id
--g
select client.name,client.city, dealer.name from client inner join dealer  on dealer.id = client.dealer_id where dealer.charge > 0.12

--h
select client.name,client.city, sell.id , sell.amount,dealer.name, dealer.charge
from (client left join sell on client.id = sell.client_id) left join dealer on dealer.id = sell.dealer_id

--i
select client.name,client.city, client.priority,dealer.name, sell.id,sell.amount
from client right outer join  dealer  on client.dealer_id = dealer.id
            left outer join sell on client.id = sell.client_id where amount >= 2000 and client.priority IS NOT  NULL;

2-Exersice
--a
drop view view1;--a
drop view view2;--b
drop view view3;--c
drop view view4 -- d
drop view view5;--e
drop view view6;--f
drop view view7;--g

--a
create  view  view1 as select  date, count(distinct client_id ), avg(amount), sum(amount) from sell group by date
--b
create  view  view2 as select  date, count(distinct client_id ), avg(amount), sum(amount) as summa
                                                from sell group by date order by summa desc LIMIT 5;
--c
create view view3 as select count(client_id),avg(amount), sum(amount) from sell group by client_id;
--d
create view view4 as
select location, charge, sum(amount) as sum, charge * sum(amount) as total_price
from sell inner join  dealer on sell.dealer_id = dealer.id group by location,charge;
--e
create view view5
as select count(client_id), avg(amount), sum(amount)
from sell inner join dealer on sell.dealer_id = dealer.id group by location;
--f
create view view6 as
select count(sell.id),avg(amount), sum(amount)
from client inner join  sell on client.id = sell.client_id group by  city;
--g
create view view7 as
select city,sum(amount) as summa
from (sell inner join  client  on sell.client_id = client.id)  group by  city
      where  summa  >  (select sum(amount) from dealer inner join sell on dealer.id = sell.dealer_id group by location)
