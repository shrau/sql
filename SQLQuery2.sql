use shravani;
select * from FACT_Sales order by sales_wk;
select * from DIM_CALENDAR;
select * from DIM_Region;
select * from DIM_Product;

select Sa.Calendar_wk,Pr.product_nk,Pr.Product,Sa.region_wk,Sa.Amount,Sa.Quantity
from FACT_Sales as Sa LEFT OUTER  JOIN DIM_Product as Pr
ON Sa.product_wk=Pr.product_wk;

select Fs.sales_wk,Fs.Calendar_wk,Dr.Region,Dr.Region_nk,Fs.Amount,Fs.Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk =Dr.Region_wk;

select * 
from FACT_sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk;

select Dr.Region,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
group by Dr.Region
ORDER BY Total_Sum DESC;

select Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
group by Dr.Region_nk
ORDER BY Total_Sum DESC;

select Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
group by Dr.Region_nk
HAVING SUM(Fs.Quantity) >1000
ORDER BY Total_Sum DESC;

select Dr.Region_nk,Dr.Region,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region='West'
GROUP BY Dr.Region_nk,Dr.Region
ORDER BY Total_Quantity DESC;

Select Dc.month_ldesc,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
GROUP BY Dc.month_ldesc
ORDER BY Dc.month_ldesc DESC;

SELECT Dp.product_nk,Dp.Product,Dc.year_num,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
GROUP BY Dp.product_nk,Dp.Product,Dc.year_num
ORDER BY Dc.year_num;

SELECT Dp.product_nk,Dc.year_num,Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region IN('West','South')
GROUP BY Dp.product_nk,Dc.year_num,Dr.Region_nk
ORDER BY Total_Quantity

SELECT Dp.product_nk,Dc.year_num,Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region NOT IN('West')
GROUP BY Dp.product_nk,Dc.year_num,Dr.Region_nk
ORDER BY Total_Quantity

SELECT Dp.product_nk,Dc.year_num,Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=Dc.calendar_wk
LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
WHERE Dr.Region_nk LIKE 'M%'
GROUP BY Dp.product_nk,Dc.year_num,Dr.Region_nk
ORDER BY Total_Quantity

SELECT Dp.product_nk,MAX(Fs.Amount)as Max_Sale,MIN(Fs.Amount)as Min_Sale,ROUND(AVG(Fs.Amount),0)as Avg_Sale
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk = Dp.product_wk
GROUP BY Dp.product_nk;

select Dr.Region_nk,SUM(Fs.Amount)as Total_Sum ,SUM(Fs.Quantity)as Total_Quantity
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
group by Dr.Region_nk
HAVING SUM(Fs.Quantity) >1000
ORDER BY Dr.Region_nk;

SELECT Fs.product_wk,Fs.Quantity,Fs.sales_wk,Fs.Amount,Dr.Region_nk
from FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
where Dr.Region_nk LIKE 'C%'
ORDER BY Fs.Amount;

select
case
when Region_nk='N. Delhi' then 'New Delhi'
when Region_nk='Calcutta' then 'Kolkata'
else Region_nk
end as Region,

SUM (Fs.Amount)as Total_Sum ,
case
when SUM(Fs.Amount)>700 then 'high'
when SUM(Fs.Amount)>500 then 'medium' 
else 'low' end as high_low,
SUM(Fs.Quantity)as Total_Quantity,
case
when SUM(Fs.Amount)/SUM(Fs.Quantity)>=0.2 then 'Expensive'
else 'Cheap'
end as Expensive_Cheap 
from FACT_Sales as Fs LEFT JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
group by Dr.Region_wk,Dr.Region_nk
ORDER BY Total_Sum DESC;

