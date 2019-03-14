proc sql;
	select * from sashelp.shoes;
quit;

proc sql;
	title "Shoes dataset";
	select Region, Product, sum(Sales) as Total_Sales format comma10. from sashelp.shoes group by 
		Region, Product order by Region, Total_Sales desc;
quit;

/* Next Example */
title "PROC PRINT Output";

proc print data=pg1.class_birthdate;
	var Name Age Height Birthdate;
	format Birthdate date9.;
run;

title "PROC SQL Output";

proc sql;
	select Name, Age, Height*2.54 as HeightCM format=5.1, Birthdate format=date9.
    from pg1.class_birthdate;
quit;

title;
