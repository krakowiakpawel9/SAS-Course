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

/* Next Example */
title "Most Costly Storms";

proc sql;
	select Event, Cost format=dollar16., year(Date) as Season from 
		pg1.storm_damage where Cost > 25000000000 order by Cost desc;
quit;


/* Next Example */
proc sql;
create table top_damage as select Event, Date format=monyy7., Cost format=dollar16.
    from pg1.storm_damage order by Cost desc;
	title "TOP 10 Storms by Damage Cost";
	select * from top_damage(obs=10);
quit;
