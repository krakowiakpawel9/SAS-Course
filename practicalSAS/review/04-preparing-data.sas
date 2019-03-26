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
	length Order_Source $8;
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

/* Homework Solution */
proc print data=sashelp.holiday;
run;

data holiday2019;
	set sashelp.holiday;
	where end=. and rule=0;
	CountryCode=substr(Category, 4, 6);
	Date=mdy(month, day, 2019);
	keep Desc Country Date CountryCode;
run;

proc freq data=holiday2019;
	tables CountryCode;
run;

/* Homework Solution */
proc print data=sales(obs=50);
run;

data sales;
	set cr.employee;
	length SalesLevel $ 10;
	where department='Sales' and TermDate=.;
	Country=upcase(Country);

	if substr(Jobtitle, 12)='I' then
		SalesLevel='Entry';
	else if substr(JobTitle, 12) in ('II', 'III') then
		SalesLevel='Middle';
	else
		SalesLevel='Senior';
run;

proc freq data=sales;
	tables SalesLevel;
run;

/* Homework Solution */
proc contents data=cr.employee;
run;

data bonus;
	set cr.employee;
	where TermDate is missing;
	YearsEmp=yrdif(HireDate, '01JAN2019'd, "AGE");

	if YearsEmp >=10 then
		do;
			Bonus=0.03*Salary;
			Vacation=20;
		end;
	else
		do;
			Bonus=0.02*Salary;
			Vacation=15;
		end;
run;

proc sort data=bonus;
	by descending YearsEmp;
run;

proc print data=bonus;
run;

proc freq data=bonus;
	tables Vacation;
run;
