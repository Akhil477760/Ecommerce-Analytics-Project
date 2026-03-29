create database ecommerce;
use ecommerce;

create table ecommerce.orders (
    InvoiceNo varchar(20),
    StackCode Varchar(20),
    Description Text,
    Quantity int,
    InvoiceDate datetime,
    UnitPrice float,
    CustomerId FLOAT,
    Country Varchar(50),
    Totalprice FLOAT
);

set GLOBAL local_infile=1;

load data local INFILE 'C:\\Users\\akhil\\OneDrive\\Desktop\\Online Retail Dataset\\cleaned_online_retail.csv'
into table ecommerce.orders
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows

# Top 10 products by revenue
SELECT DESCRIPTION, SUM(Totalprice) AS Revenue
FROM ecommerce.orders
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

# Top 5 countries by total sales
SELECT country, sum(totalprice) as Revenue
FROM ecommerce.orders
GROUP BY country
ORDER BY Revenue DESC
LIMIT 10;

# Top Customers
select customerId, sum(totalprice) as spending
from ecommerce.orders
group by customerId
order by spending desc
limit 10;

# Monthly sales trend
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(Totalprice) AS Revenue
FROM ecommerce.orders
GROUP BY Month
ORDER BY Month;

# Most Sold Products
select DESCRIPTION, sum(Quantity) as total_sold
from ecommerce.orders
group by DESCRIPTION
order by total_sold desc
limit 10;

