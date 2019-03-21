/* Validate Imported Orders Table */
proc print data=cr.orders(obs=20);
run;

proc print data=cr.orders;
	where Order_Date > Delivery_Date;
	var Order_ID Order_Date Delivery_Date;
run;

proc freq data=cr.orders;
	tables Order_Type Customer_Country Customer_Continent;
run;

proc univariate data=cr.orders;
	var Quantity Retail_Price Cost_Price;
run;

/* Preparing data  */
data profit;
	set cr.orders;
	length Orders_Source $8;
	where Delivery_Date >=Order_Date;
	Customer_Country=upcase(Customer_Country);

	if Quantity < 0 then
		Quantity=.;
	Profit=(Retail_Price - Cost_Price)*Quantity;
	format Profit dollar10.2;
	ShipDays=Delivery_Date - Order_Date;
	Age_Range=substr(Customer_Age_Group, 1, 5);

	if Order_Type=1 then
		Order_Source="Retail";
	else if Order_Type=2 then
		Order_Source="Phone";
	else if Order_Type=3 then
		Order_Source='Internet';
	else
		Order_Source='Unknown';
	drop Retail_Price Cost_Price Customer_Age_Group Order_Type;
run;

proc print data=profit;
run;

proc sql;
	create table profit_country as select profit.*, Country_Name from profit p 
		inner join cr.country_clean cc on p.Customer_Country=cc.Country_Key order by 
		Order_Date desc;
quit;