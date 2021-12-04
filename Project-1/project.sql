CREATE TABLE customers(
    id varchar(10) primary key,
    name varchar(20) NOT NULL,
    street varchar(10) NOT NULL
);
CREATE TABLE credit_card_data(
    credit_card_number varchar(12) primary key,
    id varchar(10) references customers
);
CREATE TABLE contracts(
    contract_number varchar(9) primary key NOT NULL,
    id varchar(10) references customers NOT NULL
);
CREATE TABLE telephone_numbers(
    telephone_nu varchar(20) primary key ,
    id varchar(10) references customers
);
CREATE TABLE purchases(
    tracking_code varchar(8) primary key ,
    id varchar(10) references customers,
    bar_code varchar(20) references orders,
    date_of_purchase date,
    categ varchar(1) references type_of_deliv
);
CREATE TABLE type_of_deliv(
    categ varchar(1) primary key CHECK (categ in ('A','B','C')),
    delivery_time integer,
    price integer
);
CREATE TABLE orders(
    bar_code varchar(20) primary key,
    price integer,
    type_of_package varchar(10),
    shop_name varchar(10)
);
CREATE TABLE packaging(
    type_of_package varchar(10) primary key CHECK (type_of_package in ('X','Y')),
    details varchar(10)
);

CREATE TABLE tracking(
    tracking_code varchar(8) references purchases,
    timeline date,
    status varchar(6),
    IP_address varchar NOT NULL references IP_add
);
CREATE TABLE IP_add(
    IP_address varchar primary key,
    location varchar
);
CREATE TABLE delivery_vehicle(
    tracking_code varchar(8) references purchases,
    transported_via varchar(10) references vehicle
);
CREATE TABLE vehicle(
    transported_via varchar(10) primary key ,
    name varchar(10)
);
ALTER TABLE tracking
ALTER COLUMN status TYPE varchar;
INSERT INTO customers(id, name, street) VALUES
('DB01','Client1','Street1'),
('DB02','Client2','Street2'),
('DB03','Client3','Street2'),
('DB04','Client4','Street5'),
('DB05','Client5','Street7'),
('DB06','Client6','Street1'),
('DB07','Client7','Street2'),
('DB08','Client8','Street9'),
('DB09','Client9','Street1'),
('DB10','Client10','Street3'),
('DB11','Client11','Street4');

INSERT INTO credit_card_data(credit_card_number, id)
VALUES ('CC11','DB01'),
       ('CC12','DB02'),
       ('CC13','DB03'),
       ('CC14','DB04'),
       ('CC15','DB05'),
       ('CC16','DB06');

INSERT INTO contracts(contract_number, id)
VALUES ('CN17','DB07'),
       ('CN18','DB08'),
       ('CN19','DB09'),
       ('CN20','DB10'),
       ('CN21','DB11');

INSERT INTO telephone_numbers(telephone_nu, id)
VALUES ('3429','DB01'),
       ('3209','DB02'),
       ('2345','DB03'),
        ('1243','DB04'),
        ('0943','DB05'),
        ('4368','DB06'),
        ('2343','DB07'),
        ('9084','DB08'),
        ('2132','DB09'),
        ('5465','DB10'),
       ('4311','DB11');

INSERT INTO purchases(tracking_code, id, bar_code, date_of_purchase,categ)
VALUES ('TC11','DB01','BC03','2020-02-10','A'),
       ('TC12','DB03','BC16','2020-10-23','C'),
       ('TC13','DB05','BC01','2019-11-11','B'),
       ('TC14','DB05','BC16','2019-04-29','A'),
       ('TC15','DB05','BC04','2014-01-31','A'),
       ('TC16','DB11','BC09','2018-04-27','C'),
       ('TC17','DB11','BC11','2017-06-16','C'),
       ('TC18','DB02','BC12','2018-08-04','B'),
       ('TC19','DB04','BC14','2021-07-07','C'),
       ('TC20','DB01','BC06','2016-03-09','A'),
       ('TC21','DB07','BC08','2018-04-04','A'),
       ('TC22','DB03','BC07','2021-12-25','B'),
       ('TC23','DB08','BC09','2015-11-23','C'),
       ('TC24','DB09','BC03','2020-02-10','B'),
       ('TC25','DB10','BC07','2019-03-01','C'),
       ('TC26','DB04','BC10','2016-10-21','A'),
       ('TC27','DB07','BC13','2021-12-23','B'),
       ('TC28','DB08','BC14','2019-05-08','A'),
       ('TC29','DB08','BC13','2021-12-21','C'),
       ('TC30','DB06','BC02','2021-12-14','B'),
       ('TC31','DB01','BC11','2017-02-11','A'),
       ('TC32','DB10','BC15','2020-03-12','C');

UPDATE purchases
SET date_of_purchase='2017-02-06' WHERE tracking_code='TC31';

UPDATE purchases
SET date_of_purchase='2021-10-23' WHERE tracking_code='TC12';
INSERT INTO type_of_deliv(categ, delivery_time,price)
VALUES ('A',32,50),
       ('B',23,75),
       ('C',14,100);

INSERT INTO packaging(type_of_package, details)
VALUES ('X','envelope'),
       ('Y','boxing');

INSERT INTO orders(bar_code, price, type_of_package, shop_name)
VALUES ('BC01',250,'Y','Amazon'),
       ('BC02',126,'X','Wegmans'),
       ('BC03',1200,'X','Superfresh'),
       ('BC04',350,'Y','AmericanE'),
       ('BC05',200,'X','Dillards'),
       ('BC06',200,'Y','Amazon'),
       ('BC07',780,'X','Superfresh'),
       ('BC08',970,'Y','Best Buy'),
       ('BC09',124,'Y','Amazon'),
       ('BC10',879,'X','Dillards'),
       ('BC11',950,'X','AmericanE'),
       ('BC12',30,'X','Wegmans'),
       ('BC13',275,'Y','Modells'),
       ('BC14',400,'X','Wegmans'),
       ('BC15',1500,'Y','AmericanE'),
       ('BC16',380,'X','Modells');


INSERT INTO tracking(tracking_code, timeline,status,IP_address)
VALUES ('TC11','2020-02-23','complete','IP101'),
       ('TC12','2021-10-25','processing','IP104'),
       ('TC12','2021-11-08','complete','IP102'),
       ('TC13','2019-11-13','processing','IP106'),
       ('TC13','2019-12-02','complete','IP109'),
       ('TC14','2019-04-30','processing','IP110'),
       ('TC14','2019-05-03','processing','IP103'),
       ('TC14','2019-05-28','complete','IP102'),
       ('TC15','2014-03-02','complete','IP111'),
       ('TC16','2018-04-28','processing','IP110'),
       ('TC16','2018-05-10','complete','IP102'),
       ('TC17','2017-06-29','complete','IP101'),
       ('TC18','2018-08-25','complete','IP112'),
       ('TC19','2021-07-09','processing','IP111'),
       ('TC19','2021-07-19','complete','IP109'),
       ('TC20','2016-04-10','complete','IP104'),
       ('TC21','2018-05-01','complete','IP101'),
       ('TC22','2021-12-26','unknown_accident','IP108'),
       ('TC23','2015-11-24','processing','IP102'),
       ('TC23','2015-12-10','complete','IP105'),
       ('TC24','2020-02-11','processing','IP110'),
       ('TC24','2020-02-16','processing','IP111'),
       ('TC24','2020-03-01','complete','IP101'),
       ('TC25','2019-03-14','complete','IP105'),
       ('TC26','2016-11-20','complete','IP107'),
       ('TC27','2021-12-24','processing','IP109'),
       ('TC27','2021-12-26','unknown_accident','IP108'),
       ('TC28','2019-06-07','complete','IP104'),
       ('TC29','2021-12-23','processing','IP101'),
       ('TC29','2021-12-26','unknown_accident','IP108'),
       ('TC30','2021-12-15','processing','IP106'),
       ('TC30','2021-12-17','processing','IP102'),
       ('TC30','2021-12-26','unknown_accident','IP108'),
       ('TC31','2017-02-15','processing','IP102'),
       ('TC31','2017-03-13','complete','IP105'),
       ('TC32','2020-03-26','complete','IP111');

INSERT INTO ip_add(ip_address, location)
VALUES ('IP101','City1'),
       ('IP102','City2'),
       ('IP103','City3'),
       ('IP104','City4'),
       ('IP105','City5'),
       ('IP106','City6'),
       ('IP107','City7'),
       ('IP108','City8'),
       ('IP109','City9'),
       ('IP110','City10'),
       ('IP111','City11'),
       ('IP112','City12');

INSERT INTO delivery_vehicle(tracking_code, transported_via)
VALUES ('TC11','P'),
       ('TC12','C'),
       ('TC13','C'),
       ('TC14','B'),
       ('TC15','S'),
       ('TC16','T'),
       ('TC17','M'),
       ('TC18','T'),
       ('TC19','C'),
       ('TC20','P'),
       ('TC21','M'),
       ('TC22','T');

INSERT INTO delivery_vehicle(tracking_code, transported_via)
VALUES  ('TC23','M'),
       ('TC24','M'),
       ('TC25','S'),('TC26','B'),
       ('TC27','T'),
       ('TC28','M'),
       ('TC29','T'),
       ('TC30','T'),
       ('TC31','S'),
       ('TC32','C');
INSERT INTO vehicle(transported_via, name)
VALUES ('T','truck1721'),
       ('P','plane1690'),
       ('C','car2130'),
       ('S','ship9872'),
       ('M','motorbike1232'),
       ('B','bicycle0182');

ALTER TABLE vehicle
ALTER COLUMN name TYPE varchar;

SELECT id,date_of_purchase, p.bar_code from purchases p join tracking t on p.tracking_code = t.tracking_code join delivery_vehicle dv on p.tracking_code = dv.tracking_code
join vehicle v on dv.transported_via = v.transported_via and status='unknown_accident' and dv.transported_via='T';

SELECT count(id) as cnt, id from
purchases join tracking t on purchases.tracking_code = t.tracking_code and t.status='complete' and date_part('year',date_of_purchase)='2019'
group by id
ORDER by cnt desc
LIMIT 1;

SELECT sum(o.price) as sum, id from
purchases p join type_of_deliv tod on p.categ = tod.categ and date_part('year',date_of_purchase)=2019 join orders o on p.bar_code = o.bar_code
group by id
order by sum desc;

SELECT count(id) as cnt, street from
customers
group by street;



SELECT t.timeline-p.date_of_purchase,tod.delivery_time, id, bar_code from purchases p join tracking t on p.tracking_code = t.tracking_code join type_of_deliv tod on p.categ = tod.categ
and status='complete' and t.timeline-p.date_of_purchase>tod.delivery_time;

SELECT count(p.bar_code), shop_name from
purchases p join orders o on p.bar_code = o.bar_code
group by shop_name;


CREATE VIEW simple_bill as
SELECT c.id,street, sum(o.price) as amount from
customers c join purchases p on c.id = p.id join orders o on p.bar_code = o.bar_code
group by (c.id,street);

CREATE VIEW medium_bill as
SELECT id, p.categ,sum(o.price) as tot_charge from
purchases p join type_of_deliv tod on p.categ = tod.categ join orders o on p.bar_code = o.bar_code
group by (id,p.categ);

CREATE VIEW complex_bill as
SELECT id, p.bar_code, o.price as order_price, tod.price as delivery_price, shop_name,p.categ  from
purchases p join orders o on p.bar_code = o.bar_code join type_of_deliv tod on p.categ = tod.categ;