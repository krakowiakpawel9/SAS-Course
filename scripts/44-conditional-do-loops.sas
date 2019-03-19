*************************************************;
*	There are two ways of doing conditional loop*;
*												*;
*	DO UNTIL (expression)						*;
*		code									*;
*	END 										*;
*												*;
*	DO WHILE (expression)						*;
*		code									*;
*	END						    				*;
*												*;
*	UNTIL - exectues until a condition is true  *;
*	Condition checked at the end				*;
*	always executes once						*;
*												*;
*	WHILE - executes while acondition is true   *;
*	Condition checked at the beginning			*;
*	executes only if condition is true			*;
*************************************************;

data until;
	do until (Savings > 3000);
		Amount=1000;
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
		output;
	end;
	format Savings comma12.2;
run;

data until;
	do until (Savings > 3000);
		Amount=100;
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
		output;
	end;
	format Savings comma12.2;
run;

data while;
	do while (Savings <=3000);
		Amount=1000;
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
		output;
	end;
run;

/* Homework Solution */
proc print data=pg2.savings;
proc print data=Savings3K;
run;

data Savings3K;
	set pg2.savings;
	Month=0;
	Savings=0;

	do until (Savings>3000);
		Month+1;
		Savings+Amount;
		Savings+(Savings*0.02/12);
	end;
	format Savings comma12.2;
run;

data Savings3K;
	set pg2.savings;
	Month=0;
	Savings=0;

	do while (Savings <=3000);
		Month+1;
		Savings+Amount;
		Savings+(Savings*0.02/12);
	end;
	format Savings comma12.2;
run;

data Savings10K;
	set pg2.savings;
	month=0;
	Savings=0;

	do while (Savings < 10000);
		Month + 1;
		Savings + Amount;
		Savings + Savings*0.02/12;
	end;
	format Savings 12.2;
run;

/* Homework Solution */
proc print data=pg2.savings;
proc print data=pg2.savings2;
run;

/* Incorrect, because until causes that at least one loop is exectuded */
/* even though the Savings exceed 3000 pln */
data MonthSavings;
	set pg2.savings2;
	Month=0;

	do until (Savings >= 3000);
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
	end;
	format Savings comma12.2;
run;

data MonthSavings;
	set pg2.savings2;
	Month=0;

	do while (Savings < 3000);
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
	end;
	format Savings comma12.2;
run;