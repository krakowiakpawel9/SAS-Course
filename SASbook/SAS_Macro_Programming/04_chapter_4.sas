/*Program 4*/
%macro saleschart;
	goptions reset=all;
	pattern1 c=graybb;
	goptions ftext=swiss rotate=landscape;
	title "Sales Report for Week Ending &sysdate9";

	proc gchart data=temp;
		hbar section / type=sum;
	run;

%mend saleschart;

%saleschart;

/*Program 5*/
options mprint mlogic;

%macro listparm(opts, start, stop);
	title "Books sold by section Between &start and &stop";

	proc means data=ytdsales &opts;
		where "&start"d le datesold le "&stop"d;
		class section;
		var saleprice;
	run;

%mend listparm;

%listparm(,01SEP2007, 15SEP2007);
%listparm(n sum, 01JAN2007, 15JAN2007);

/*Program 6*/
options mprint mlogic;

%macro keyparm(options=N SUM MIN MAX, start=01JAN2007, end=31DEC2007);
	title "Books sold between &start and &end";

	proc means data=ytdsales &options;
		where "&start"d le datesold le "&end"d;
		class section;
		var saleprice;
	run;

%mend keyparm;

%keyparm;
%keyparm(options=n sum, start=01JUN2007, end=15JUN2007);

/*Program 7*/
%macro mixparm(stats, othropts, start=01JAN2007, end=31DEC2007);
	title "Books sold between &start to &end";
	proc means data=ytdsales &stats &othropts;
		where "&start"d le datesold le "&end"d;
		class section;
		var saleprice;
	run;
%mend mixparm;

%mixparm;
%mixparm(,missing);
