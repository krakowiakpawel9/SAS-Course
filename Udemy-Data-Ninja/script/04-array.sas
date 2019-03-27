data sixvar;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/6var.txt";
	input var_1-var_6;
run;

data recode;
	set sixvar;

	if var_2 < 5 then
		var_2=.;
run;

data recode_array;
	set sixvar;
	array recode(6) var_1-var_6;

	do i=1 to 6;

		if recode(i) < 40 then
			recode(i)=.;
	end;
run;

proc print data=sixvar;
proc print data=recode;
proc print data=recode_array;
run;

data tax;
	set sixvar();
	array arr(6) var_1-var_6;

	do i=1 to 6;
		arr(i)=arr(i) * 0.81;
	end;
	drop i;
run;

data split;
	set sixvar;
	array arr(3) var_1-var_3;

	do i=1 to 3;
		arr(i)=arr(i) * 1000;
	end;
	array arr_2(3) var_4-var_6;

	do i=1 to 3;
		arr_2(i)=arr_2(i) / 10;
	end;
	drop i;
run;

data new_tax;
	set sixvar;
	array arr(6) var_1-var_6;
	array arr_new(6) tax_1-tax_6;

	do i=1 to 6;
		arr_new(i)=arr(i) * 0.05 + arr(i);
	end;
	drop i;
run;

proc print data=new_tax;
run;