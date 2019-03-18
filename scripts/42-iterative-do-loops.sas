******************************************************;
*	DO index-column=start TO stop <by increment>;
*	repetitive code;
*	END;
******************************************************;

proc print data=sashelp.shoes(obs=5);
run;

data forecast;
	set sashelp.shoes(rename=(Sales=ProjectedSales));

	do Year=1 to 3;
		ProjectedSales=ProjectedSales * 1.05;
		output;
	end;
	keep Region Product Subsidiary Year ProjectedSales;
run;

data fore;
	set sashelp.shoes(rename=(Sales=ProSales));

	do Round=1 to 5;
		ProSales=ProSales * 1.1;
		output;
	end;
	keep Region Product Subsidiary Round ProSales;
run;

/* Homework Solution */

data YearlySavings;
	Amount=200;

	do Month=1 to 12;
		Savings + Amount;
		output;
	end;
	format Savings 12.2;
run;

data YearlySavingsProc;
	Amount=200;
	Interest=0.02;

	do Month=1 to 12;
		Savings + (Amount + Amount*0.02/12);
		output;
	end;
	format Savings 12.2;
run;

data YearlySavings;
    Amount=200;
    do Month=1 to 12;
       Savings+Amount;
       Savings+(Savings*0.02/12);
       output;
    end;
    format Savings 12.2;
run;

/* Homework Solution */
/* Nested do loops */
proc print data=pg2.savings;
run;


data Five;
	set pg2.savings;

	do Year=1 to 3;

		do Month=1 to 12;
			Aggregat + Amount;
			output;
		end;
	end;
run;

proc print data=Five;
run;

data Five_Proc;
	set pg2.savings;

	do Year=1 to 3;

		do Month=1 to 12;
			Aggregat + Amount;
			Aggregat + Aggregat*0.02/12;
			Normal + Amount;
			output;
		end;
	end;
	format Aggregat Normal comma15.2;
run;

data Five_Proc;
	set pg2.savings;
	Aggregat=0;
	Normal=0;

	do Year=1 to 3;

		do Month=1 to 12;
			Aggregat + Amount;
			Aggregat + Aggregat*0.02/12;
			Normal + Amount;
			output;
		end;
	end;
	format Aggregat Normal comma15.2;
run;
