proc sql;
	select * from sashelp.shoes;
quit;

proc sql;
	title "Shoes dataset";
	select Region, Product, sum(Sales) as Total_Sales format comma10. from sashelp.shoes group by 
		Region, Product order by Region, Total_Sales desc;
quit;

