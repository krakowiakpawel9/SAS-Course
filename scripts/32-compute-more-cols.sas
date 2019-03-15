libname pg2 "/folders/myfolders/EPG294/data";

proc print data=pg2.class_quiz(obs=10);
run;

data quiz_summary;
	set pg2.class_quiz;
	Name=upcase(Name);
	Mean1=mean(Quiz1, Quiz2, Quiz3, Quiz4, Quiz5);

	/* Numbered Range: col1-coln where n is a sequential number */
	Mean2=mean(of Quiz1-Quiz5);

	/* Name Prefix: all columns that begin with the specified character string */
	Mean3=mean(of Q:);
run;

data quiz_summary;
	set pg2.class_quiz;
	Name=upcase(Name);
	AvgQuiz_1=mean(of Q:);
	AvgQuiz_2=mean(of Quiz1-Quiz5);
	format Quiz1-Quiz3 3.1;
run;

data format_numeric;
	set pg2.class_quiz;
	format _numeric_ 3.1;
	*format _character_ $ 7;
	*format _all_ ;
run;