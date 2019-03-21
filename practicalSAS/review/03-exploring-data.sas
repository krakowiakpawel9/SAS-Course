Holibname ctryxl xlsx 
	"/folders/myfolders/SAS-Course/practicalSAS/data/country_lookup.xlsx";

proc print data=ctryxl.countries(obs=30);
run;

/* Sort values to show if there are any duplicats */
proc freq data=ctryxl.countries order=freq;
	tables Country_Key Country_Name;
run;

/* Subseting rows where frequency was grater than one */
proc print data=ctryxl.countries;
	where Country_Key in ('AG', 'CF', 'GB', 'US');
run;

/* Extracting the duplicate rows */
proc sort data=ctryxl.countries out=country_clean nodupkey dupout=dups;
	by Country_Key;
run;

*******************************
Validate Imported Orders Table
*******************************;

proc print data=cr.orders(obs=10);
run;

/* Rules of thumbs: check date, for example StartDate < EndDate */
proc print data=cr.orders;
	where Order_Date > Delivery_Date;
	var Order_ID Order_Date Delivery_Date;
run;

proc freq data=cr.orders;
	tables Order_Type Customer_Country Customer_Continent;
run;

proc contents data=cr.orders;
run;

proc means data=cr.orders maxdec=0;
	var Quantity Retail_Price Cost_Price;
run;

proc univariate data=cr.orders;
	var Quantity Retail_Price Cost_Price;
run;

/* Homework solution */
proc sort data=sashelp.baseball out=baseball_Sort;
	by Team Name;
run;

proc print data=baseball_Sort;
	where Team in ("San Francisco", "Los Angeles", "Oakland");
	keep Name Team Salary Cr:;
run;

proc freq data=baseball_Sort order=freq;
	tables Position;
run;

proc means data=baseball_Sort maxdec=0 sum mean;
	var Salary;
run;

/* Homework Solution */
proc print data=cr.employee_raw;
run;

proc freq data=cr.employee_raw order=freq;
	tables EmpID;
run;

proc sort data=cr.employee_raw nodupkey out=employee_clear dupout=dups;
	by EmpID;
run;

proc freq data=cr.employee_raw;
	tables Country;
run;

proc freq data=cr.employee_raw;
	tables Department;
run;

data good bad;
	set cr.employee_raw;

	if TermDate < HireDate and TermDate ne '.' then
		output bad;
	else
		output good;
run;

/* Homework Solution */
proc sort data=cr.employee_raw out=emp_sort noduprecs dupout=dups;
	by _all_;
run;

proc print data=emp_sort(where=(JobTitle like '%Logistics%'));
	format hiredate ddmmyy10.;
run;

proc means data=cr.employee_raw mean;
	where HireDate ge '01JAN2010'd and TermDate is missing;
	var salary;
run;

proc univariate data=cr.employee_raw;
var Salary;
run;