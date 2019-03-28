/*****************
trim function
 ******************/
data trim;
	input fname$ lname$ age score;
	name=trim(lname)||', '||(fname);
	datalines;
Alex Benson 27 45
;
run;

proc contents data=trim;
proc print data=trim;
run;

data trim_2;
	length lname $9;
	input fname$ lname$ domain$ ctry$;
	email=lowcase(trim(fname))||'.'||lowcase(trim(lname))||'@'||trim(domain)||'.'||'pl';
	datalines;
Pawel Krakowiak pkobp pl
jan nowak dmns com
;
run;

/*****************
compress function
 ******************/
data compressed;
	input phone$1-15;
	phone1=compress(phone);
	phone2=compress(phone, '(-)', 's');
	datalines;
(314)456-4768
(314) 453-56 78
;
run;

proc contents data=compressed;
proc print data=compressed;
run;

data compressed_2;
	input code$1-20;
	without_a = compress(code, 'aei');
	datalines;
pawelkrakowiak
smalmarket
;
run;