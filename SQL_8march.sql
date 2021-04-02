use shravani;
select * from DIM_CALENDAR
select * from DIM_Product;
select * from DIM_Region;
select * from FACT_Sales;


select test.*,RANK() over(partition by year_num,region_nk order by Total_Sum DESC)TRank  from
(
SELECT Dp.product_nk,Dc.year_num,Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region IN('West','South')
GROUP BY Dp.product_nk,Dc.year_num,Dr.Region_nk ) as test order by year_num

select * from
(
select test.*,DENSE_RANK() over(partition by year_num,region_nk order by Total_Sum DESC)TRank  from
(
SELECT Dp.product_nk,Dc.year_num,Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region IN('West','South')
GROUP BY Dp.product_nk,Dc.year_num,Dr.Region_nk ) as test) test2 where TRank = 1;

select test.*,SUM(Total_Sum) over(partition by region_nk,year_num,month_num)TRank  from
(
SELECT Dp.product_nk,Dc.year_num,Dc.month_num,Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region IN('West','South')
GROUP BY Dp.product_nk,Dc.year_num,Dc.month_num,Region_nk ) as test


select test.* from (
select * from FACT_Sales where product_wk in(select product_wk from DIM_Product where product_nk like'S%')) as test;

select Fs.Amount,Fs.Quantity,Fs.Calendar_wk,Fs.product_wk
FROM FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region='West'
GROUP BY Fs.Amount,Fs.Quantity,Fs.Calendar_wk,Fs.product_wk
ORDER BY Fs.Amount;


select * from FACT_Sales where Calendar_wk in (select calendar_wk from DIM_CALENDAR where day_of_month=2 )

SELECT Fs.sales_wk,Fs.region_wk,Fs.Amount,Fs.Quantity,Dp.product_nk
FROM FACT_SALES as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk= Dp.product_wk
WHERE Dp.product_wk=1
GROUP BY Fs.sales_wk,Fs.region_wk,Fs.Amount,Fs.Quantity,Dp.product_nk
ORDER BY Fs.Amount DESC