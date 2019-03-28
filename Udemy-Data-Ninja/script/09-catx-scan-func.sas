/******************************************
catx - remove leading and trailing blanks
and connateate by separator
 *******************************************/
data catx_func;
	sep=',';
	first='     Larry';
	last='Larryson    ';
	result=catx(sep, first, last);
	drop sep;
run;

proc print data=catx_func;
run;

data catx_func;
	sep='#';
	first='     abs';
	last='calistenics    ';
	third='   physique';
	result=catx(sep, first, last, third);
	drop sep;
run;

/******************************************
scan - scan variable
 *******************************************/
data scan_func;
	sep=',';
	first='     abs';
	last='calistenics    ';
	third='   physique';
	result=catx(sep, first, last, third);
	sc=scan(result, 1);
	drop sep;
run;

data scan_func;
	sep='#';
	first='     abs';
	last='calistenics    ';
	third='   physique';
	result=catx(sep, first, last, third);
	sc_1=scan(result, 1, '#');
	sc_2=scan(result, 2, '#');
	drop sep;
run;