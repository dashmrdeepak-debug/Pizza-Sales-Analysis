use pizza;
SELECT * FROM pizza.pizza_sales1;
select sum(total_price)/count(distinct order_id) as avg_order_value from pizza_sales1;
select sum(total_price) from pizza_sales1;
select sum(quantity) from pizza_sales1;
select count(distinct order_id) from pizza_sales1;
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct(order_id)) 
as decimal(10,2)) as decimal(10,2)) avg_pizzaper_order_ from pizza_sales1;
select dayname(order_date) as dn,count(distinct order_id) from pizza_sales1 group by dayname(order_date);
select order_date from pizza_sales1 limit 20;
select count(*) from pizza_sales1 where order_date is null;
select count(*) from pizza_sales1 where dayname(order_date) is null;
-- select cast(trim(order_date) as date) as dn ,str_to_date(trim(reverse(order_date)),'%d%m%y')
-- from pizza_sales1 ;
-- select reverse(order_date) from pizza_sales1;
select dayname(ordr_date) ordr_day,count(distinct order_id) tot_order from
(select date_format(str_to_date(order_date,"%d-%m-%Y"),"%Y-%m-%d") as ordr_date,order_id from pizza_sales1)  ps group by ordr_day ;-- Y return 4 char of year
select cast(order_time as time) as ordr_time from pizza_sales1;

select * from pizza_sales1;
-- select od,dayname(cast(od as date)) from (select trim(order_date) as od from pizza_sales1) ps;
select monthname(ordr_date) ordr_month,count(distinct order_id) tot_order from
(select date_format(str_to_date(order_date,"%d-%m-%Y"),"%Y-%m-%d") as ordr_date,order_id from pizza_sales1)  ps group by ordr_month ;
-- with ordr_date_final(ordr_date,order_id) as 
-- (select date_format(str_to_date(order_date,"%d-%m-%Y"),"%Y-%m-%d") as ordr_date,order_id from pizza_sales1)
WITH ordr_date_final (ordr_date, order_id, pizza_id) AS (
    SELECT DATE_FORMAT(STR_TO_DATE(order_date, "%d-%m-%Y"), "%Y-%m-%d") AS ordr_date,
           order_id,
           pizza_id
    FROM pizza_sales1
)
SELECT pizza_category,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales1) AS pct_sales
FROM pizza_sales1 p
JOIN ordr_date_final o
  ON p.pizza_id = o.pizza_id -- or join using pizza_id if better
WHERE MONTHNAME(o.ordr_date) = 'January'
GROUP BY pizza_category;

  
  CREATE TABLE ct2 AS
SELECT pizza_id,
       DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%Y-%m-%d') AS ordr_date,
       order_id
FROM pizza_sales1;

SELECT pizza_category,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales1 join ct2 WHERE MONTHNAME(ct2.ordr_date) = 'January' ) AS pct_sales
FROM pizza_sales1 p
JOIN ct2 c
ON p.pizza_id = c.pizza_id
WHERE MONTHNAME(c.ordr_date) = 'January'
GROUP BY pizza_category;

select pizza_size,cast(sum(total_price) as decimal(10,2)),cast(sum(total_price)*100/(select sum(total_price) from pizza_sales1) as decimal(10,2)) pct from pizza_sales1 group by pizza_size order by pct;

select pizza_name,sum(total_price) rev from pizza_sales1 group by pizza_name order by rev desc limit 5;
select pizza_name,cast(sum(total_price) as decimal(10,2)) rev from pizza_sales1 group by pizza_name order by rev limit 5;
select pizza_name,sum(quantity) tot_quantity from pizza_sales1 group by pizza_name order by tot_quantity desc limit 5;