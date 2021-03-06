create or replace function add(value integer)
      returns integer as $$
      begin
        return value+1;
      end; $$
      language plpgsql;
select add(19);
--2
create or replace function sum_of_two(val1 numeric,val2 numeric)
      returns numeric as $$
      begin
         return val1 + val2;
      end; $$
      language plpgsql;
select sum_of_two(10,20);
--3
create or replace function is_divisible(value integer)
      returns bool as $$
      begin
          if value%2=0 then
              return true;
          else
              return false;
      end if;
      end; $$
      language plpgsql;
select is_divisible(15);
--4
create or replace function is_valid(password varchar)
      returns bool as $$
      begin
         if length(password)>0 then
            return true;
         else
            return false;
      end if;
      end; $$
      language plpgsql;
drop function is_valid(password varchar);
select is_valid('');
--5
create or replace function in_out(value integer,out square integer,out cub integer)
     as $$
     begin
     square := value*value;
     cub := value*value*value;
     end;$$
     language plpgsql;
select * from in_out(5);

--2.Create a trigger that:
create table change_time(
    times timestamp
);
create table queries(
    operation varchar
);
create or replace function curr_time() returns trigger
   as $$
   begin
       insert into change_time values(now());
       return new;
   end;
   $$ language plpgsql;
create trigger process_time before insert or update or delete on queries
    for each statement execute procedure curr_time();

insert into queries values('insert');
update queries set operation = 'update' where operation='insert';
select * from change_time;
--2
create table persons(
    name varchar,
    year_birth integer
);
create table ages(
    name varchar,
    age integer
);
create or replace function solve() returns trigger
 as $$
   begin

       insert into ages values(new.name,2021-new.year_birth);
       return new;
   end;
   $$ language plpgsql;
create trigger tr_pers after insert on persons
    for each row execute procedure solve();

insert into persons values ('Alan',1997);
select * from ages;
--3
create table items(
    id integer,
    price float
);
drop table  items;
create or replace function tax() returns trigger
 as $$
   begin

       update items set price = price * 1.12 where price = new.price;
       return new;
   end;
   $$ language plpgsql;
create trigger tr_tax after insert on items
    for each row execute procedure tax();
insert into items values (1,180);
select * from items;
--5
create trigger tr_tax after insert on items
    for each row execute procedure is_valid();
create trigger tr_tax after insert on items
    for each row execute procedure in_out();

--4.Create procedures that:
create table empl(
    id integer primary key ,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
);
drop table empl;
insert into empl values (1,'mara','12-05-1997',24,45000,1,6000);
insert into empl values (2,'dara','10-04-1985',36,75000,3,7000);
insert into empl values (3,'gara','11-05-1967',54,100000,10,15000);
insert into empl values (4,'sara','01-06-1991',29,30000,4,4000);
--a
create or replace procedure increase()
      as $$
      begin
          update empl set salary = salary*1.1 where workexperience>=2;
          update empl set discount=discount*1.1 where workexperience>=2;
          update empl set discount = discount*1.01 where workexperience>=5;
      end; $$
      language plpgsql;
call increase();
select * from empl;
--b
create or replace procedure increase2()
      as $$
      begin
          update empl set salary = salary*1.15 where age>=40;
          update empl set salary = salary*1.15 where workexperience>=8;
          update empl set discount = discount*1.20  where workexperience>=8;
      end; $$
      language plpgsql;
call increase2();