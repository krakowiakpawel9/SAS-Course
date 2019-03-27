%let start_time = %sysfunc(datetime());

data rand;
	call streaminit(12345);

	do i=1 to 10000;
		x=rand('Normal');
		output;
	end;
run;

proc sgplot data=rand;
	title "Random Values from N(0,1)";
	histogram x / nbins=20;
run;

/* proc freq data=rand; */
/* run; */

data _null_;
	time=datetime() - start_time;
	putlog time;
run;

/* Next example  */
%let start_time = %sysfunc(datetime());

data rand_uni;
	call streaminit(12345);

	do i=1 to 10000;
		x=rand('Uniform');
		output;
	end;
run;

proc sgplot data=rand_uni;
	title "Random Values from U(0,1)";
	histogram x / nbins=20;
run;

data _null_;
	time=datetime() - start_time;
	putlog time;
run;

%let end_time=%sysfunc(datetime());
%let run_time=%sysfunc(putn(&end_time - &start_time, 12.4));
%put It took &run_time second to run the program;

/* Next example  */
%let start_time = %sysfunc(datetime());

data rand_gamma;
	call streaminit(12345);

	do i=1 to 10000;
		x=rand('Gamma', 3);
		output;
	end;
run;

proc sgplot data=rand_gamma;
	title "Random Values from Gamma";
	histogram x / nbins=100;
run;

data _null_;
	time=datetime() - start_time;
	putlog time;
run;

%let end_time=%sysfunc(datetime());
%let run_time=%sysfunc(putn(&end_time - &start_time, 12.4));
%put It took &run_time second to run the program;

