data salary;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/salary.txt";
	input year salary;
run;

data salary(keep=salary rename=salary=salaryemp);
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/salary.txt";
	input year salary;
run;

*	more options to check: ALTER, BUFNO, BUFSIZE, CNTLLEV;

proc print data=salary;
proc print data=salary(obs=2);
proc print data=salary(firstobs=3 obs=5);
run;

*	different delimiter;

data salary_dot;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/salary_dot.txt" 
		dlm='.';
	input year salary;
run;

*	free formated;

data beer;
	length brand $10;
	input brand$ origin$ price;
	cards;
Budweiser USA 14.99
Heineken NED 13.99
Corona MEX 12.99
;
run;

*	fixed formatted, column definitions;

data beer_fix;
	input brand$ 1-9 origin$ 10-12 price 13-17;
	cards;
BudweiserUSA14.99
Heineken NED13.99
Corona   MEX12.99
;
run;

*	date;

data dates;
	input name $ bday date11.;
	cards;
Eric 4 Mar 1985
Doug 15 Feb 1987
Lisa 5 Jan 1987
;
run;

proc print data=dates;
	format bday ddmmyy10.;
run;

*	calculate new columns;

data house;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/houseprice.txt";
	input type $ price tax;
	actual_price=price*(1-tax);
	actual_tax=price*tax;
run;

data house;
	input type $ price tax;
	actual_price=price*(1-tax);
	actual_tax=price*tax;
	datalines;
Single 300000 0.20
Single 250000 0.25
Duplex 175000 0.15
;
run;

*	name the same column;

data sales;
	input Name$ Sales_1-Sales_4;
	total=sum(of Sales_1-Sales_4);
	cards;
Greg 10 2 40 0
John 15 5 10 100
Mark 20 0 3 10
;
run;

*	filtering;

data filter;
	set house;
	where price > 200000;
run;

data filter;
	set house;

	if price > 200000;
run;

*	if statement;

data sales;
	input Name$ Sales_1-Sales_4;
	total=sum(of Sales_1-Sales_4);
	Fired='';

	if Name='Greg' and total >=52 then
		Fired='N';
	cards;
Greg 10 2 40 0
John 15 5 10 100
Mark 20 0 3 10
;
run;

*	if statement with do;

data sales;
	input Name$ Sales_1-Sales_4;
	total=sum(of Sales_1-Sales_4);
	Fired='';

	if Name='Greg' and total >=52 then
		do;
			Fired='N';
			total=total + 10;
		end;
	cards;
Greg 10 2 40 0
John 15 5 10 100
Mark 20 0 3 10
;
run;

*	if then else statement;

data sales;
	input Name$ Sales_1-Sales_4;
	total=sum(of Sales_1-Sales_4);
	Fired='';
	Performance="";

	if total < 40 then
		Performance='l';
	else if total < 80 then
		Performance='a';
	else
		performance='h';
	cards;
Greg 10 2 40 0
John 15 5 10 100
Mark 20 0 3 10
;
run;

*	where expression - three ways;

proc sql;
	select total from sales where total > 50;
quit;

proc print data=sales(where=(total>50));
run;

proc print data=sales;
	where total > 50;
run;

*	sort procedure;

proc sort data=house out=sort_house;
	by descending tax;
run;

proc print data=house;
proc print data=sort_house;
run;

data houseprice;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/houseprice.txt";
	input type$ price tax;
run;

data newhouse;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/newhomes.txt";
	input type$ price tax;
run;

proc print data=houseprice;
proc print data=newhouse;
run;

*	before the merge step you have to sort data;

proc sort data=houseprice out=h_sort;
	by descending price;

proc sort data=newhouse out=n_sort;
	by descending price;
run;

data all;
	merge h_sort n_sort;
	by descending price;
run;

proc print data=all;
run;