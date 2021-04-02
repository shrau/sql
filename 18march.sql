use shravani;
select * from FACT_Sales order by sales_wk;
select * from DIM_CALENDAR;
select * from DIM_Region;
select * from DIM_Product;

SELECT Fs.sales_wk,Fs.Calendar_wk,Fs.Amount,Fs.Quantity,Dp.Product
FROM FACT_Sales as Fs LEFT OUTER JOIN DIM_Product as Dp
ON Fs.product_wk=Dp.product_wk
WHERE Dp.product_nk IN ('Shoe','Shirt')
GROUP BY Fs.sales_wk,Fs.Calendar_wk,Fs.Amount,Fs.Quantity,Dp.Product
ORDER BY Fs.Amount

SELECT
CASE 
when Region_nk='Hyderabad' then 'HB'
when Region_nk='Lucknow' then 'LK'
else Region_nk
end as Region_Name,
Fs.Amount,Dr.Region_wk,Dr.Region
from FACT_Sales as Fs left outer join DIM_Region as Dr
on Fs.region_wk=Dr.Region_wk
group by Fs.Amount,Dr.Region_wk,Dr.Region,Dr.Region_nk


SELECT Fs.Amount,Fs.Quantity,Dc.calendar_nk,Dr.Region_nk,Dr.Region
FROM FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=DC.calendar_wk
WHERE Dr.Region IN('South','West')
GROUP BY Fs.Amount,Fs.Quantity,Dc.calendar_nk,Dr.Region_nk,Dr.Region
ORDER BY Fs.Amount

SELECT 
case
when (Fs.Amount)<30 then 'Min'
when (Fs.Amount)>30 then 'Medium'
end as Total_sum,
Fs.Quantity,Dc.calendar_nk,Dr.Region_nk,Dr.Region
FROM FACT_Sales as Fs LEFT OUTER JOIN DIM_Region as Dr
ON Fs.region_wk=Dr.Region_wk
LEFT OUTER JOIN DIM_CALENDAR as Dc
ON Fs.Calendar_wk=DC.calendar_wk
GROUP BY Fs.Amount,Fs.Quantity,Dc.calendar_nk,Dr.Region_nk,Dr.Region
ORDER BY Fs.Amount