create database project_KML_DSA

------create a table 
select * from KMS_DATASET

----PRODUCT WITH HIGHEST SALES 
select top 1 product_category, max (sales) as highestsales 
from(
select product_category, sales, order_id
from kms_dataset) as productsales 
group by product_category

----the Top 3 and Bottom 3 regions in terms of sales
select top 3 * from(
select region, sales 
from Kms_dataset) AS kms
order by sales desc
-----Bottom 3 regions
select top 3 * from(
select region, sales 
from Kms_dataset) AS kms
order by sales asc

----the total sales of appliances in Ontario
select region, sum (sales) as totalsales
from kms_dataset
where 
region = 'ontario' and 
product_sub_category= 'appliances'
group by region


---Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
select top 10 customer_segment, Region, sum(order_quantity * unit_price) as revenue
from KMS_dataset
group by Customer_Segment, Region
order by revenue asc 
----from the result given, KMS can do customer survey in those region to understand the decrease of revenue. 
----KMS, using marketing techniques should convince those regions in increasing  their order_quantity
---KMS can provide products more suitable in that region

-------KMS incurred the most shipping cost using which shipping method?
select top 1 ship_mode, max (Shipping_Cost) as highestshippingmethod
from(
select Shipping_Cost, ship_mode, order_id
from kms_dataset) as shippingmode 
group by Ship_Mode

-------Who are the most valuable customers, and what products or services do they typically purchase?
select top 1 customer_segment, max(Product_Category) as mostvaluable
from KMS_dataset
group by Customer_Segment, Product_Category
order by mostvaluable desc 

----Which small business customer had the highest sales? (technology)

select top 1 Customer_Segment, Product_Category, product_sub_category,  max (sales) as highestsales
from kms_dataset
where 
Customer_Segment = 'small business' 
group by Customer_Segment, Product_Category, product_sub_category
order by highestsales desc

-----Which Corporate Customer placed the most number of orders in 2009 – 2012?
select  Customer_Segment, Product_Category,  max (Order_Quantity) as mostordered
from kms_dataset
where 
Customer_Segment = 'corperate' and
Order_Date between 2009 and 2012
group by Customer_Segment, Product_Category
order by mostordered desc


-----Which consumer customer was the most profitable one?
select top 1 Customer_Segment, Product_Category, product_sub_category,  max (sales) as profitable 
from kms_dataset
where 
Customer_Segment = 'consumer' 
group by Customer_Segment, Product_Category, product_sub_category
order by profitable desc

select top 1 Customer_Segment, product_category, customer_name,  max (sales) as profitable 
from kms_dataset
where 
Customer_Segment = 'consumer' 
group by Customer_Segment, Product_Category, Customer_Name
order by profitable desc

---------Which customer returned items, and what segment do they belong to?

select * from order_status
select [dbo].[KMS_dataset].Order_ID,
	   [dbo].[Order_Status].order_id,
	   [dbo].[KMS_dataset].Customer_Segment,
	   [dbo].[KMS_dataset].Product_Category,
	   [dbo].[KMS_dataset].Customer_Name,
	    [dbo].[Order_Status].[status]
	

from [dbo].[KMS_dataset]
inner join  [dbo].[Order_Status]
on  [dbo].[Order_Status].order_id = [dbo].[KMS_dataset].Order_ID

---If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, 
---do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer
SELECT 
    Order_ID,
    Order_Priority,
    Ship_Mode,
    Shipping_Cost
FROM 
    KMS_dataset
WHERE 
    (Order_Priority IN ('High', 'Critical') AND Ship_Mode != 'Express Air')

    OR 
    (Order_Priority IN ('Low', 'Medium') AND Ship_Mode = 'Express Air');
	---yes 