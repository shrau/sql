use shravani;
select * from FACT_Sales order by sales_wk;
select * from DIM_CALENDAR;
select * from DIM_Region;
select * from DIM_Product;

select min(fs.Amount)as MIN_Sale,MAX(fs.Amount)as MAX_Sale,dr.Region,dc.year_num,fs.Quantity
from FACT_Sales as fs LEFT OUTER JOIN DIM_Region as dr
ON fs.region_wk=dr.Region_wk 
LEFT OUTER JOIN DIM_Calendar as dc
on fs.Calendar_wk=dc.calendar_wk
group by fs.Amount,dr.Region,dc.year_num,fs.sales_wk,fs.Quantity
order by dc.year_num


