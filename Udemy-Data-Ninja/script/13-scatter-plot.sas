data s;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/houseprice.txt";
	input types$ price tax;
run;

ods graphics on;

proc sgplot data=s;
	scatter x=price y=tax / group=types;
run;

proc sgplot data=s;
	vbar types;
run;

proc sgplot data=s;
	hbar types;
run;
