************************************************
*
*	Basic function:
*	upcase(char) - 						uppercase letter
*	propcase(char, <delimiters>) - 		first letter is uppercase
*	substr(char, position, <length>) - 	extract substring from string
*
*	compbl(string) - returns a chracter string with all multiple blanks in the source string converted to
*					 single blanks,  this statement is used to remove any extra blanks that there may be in column
*	compress(string, <character>) - returns a character string with specified characters removed from
*									the source string
*	stip(string) - returns a character string with leading and trailing blanks removed.
*	scan(string, n, <delimiters>) - extract sequnece from particular string, default = ','

	*									alternatives = (blank, !, $, %, &, (), *, +, -, ., /,<, ^, |) and ;
*
*	find(string, substring, <modifiers>) - search for particular substring and returns the position
*	trunwrd(source, target, replacement) - find and replace 
*
*	length(string) 		returns the length of a non-blank character string, excluding trailing blanks,
*						returns 1 for a completly blank string
*	anydigit(string)	returns the first position at which a digit is found in the string
*	anyaplha(string)    returns the first position at which an alpha character is found in the string
*   anypunct(string) 	returns the first position at which punctuation character is found in the string
*
*	cat(string1, string2,...)		concatenates strings together, does not remove leading or trailing blanks
*	cats(string1, string2, ...)     concatenates stringd together, removes leading and trailing blanks from each string
*	catx('delimier', string1, string2, ...) concatenates strings together, using delimiter

	************************************************;

proc print data=pg2.weather_japan;
run;

/* The second argument of propcase function allows to specify which delimiters should be treated as main */
/* For example if we have word 'Fake-News' and wanted to display 'Fake-news' */
data japan;
	set pg2.weather_japan;
	Location=compbl(Location);
	City=propcase(scan(Location, 1, ','), ' ');
	Prefecture=scan(Location, 2, ',');
	Country=scan(Location, -1);
run;

/* compbl() allows to truncate all blanks spaces */
/* compress() allows to remove specified characters from the string */
data weather_japan_clean;
	set pg2.weather_japan;
	NewLocation=compbl(Location);
	NewStation=compress(Station);
	NewStation_more_clean=compress(Station, '- ');
run;

/* Homework case */
data weather_japan_clean;
	set pg2.weather_japan;
	Location=compbl(Location);
	City=propcase(scan(Location, 1, ','), ' ');
	Prefecture=scan(Location, 2, ',');
	putlog Prefecture $quote20.;
	*if Prefecture="Tokyo";
run;

data weather_japan_clean;
	set pg2.weather_japan;
	Location=compbl(Location);
	City=propcase(scan(Location, 1), ' ');
	Prefecture=strip(scan(Location, 2, ','));
	putlog Prefecture=;

	if Prefecture='Tokyo';
run;

/* Using concatenating functions */
data storm_damage2;
	set pg2.storm_damage;
	drop Date Cost Deaths;
	CategoryLoc=find(Summary, 'category', 'i');
	*if CategoryLoc > 0 then Category=substr(Summary,CategoryLoc, 10);
run;

libname pg2 "/home/krakowiakpawel90/EPG294/data";

proc print data=pg2.np_monthlytraffic(obs=10);
proc contents data=pg2.np_monthlytraffic;
run;

data clean_traffic;
	set pg2.np_monthlytraffic;
	drop year;
	length Type $ 5;
	ParkType=scan(ParkName, -1, ' ');
	ParkName=scan(ParkName, 1, ' ');
	Location=propcase(Location);
	Region=compress(upcase(Region));
	*putlog "After ParkType assignment";
	*putlog ParkName $quote40. Region $quote40.;
run;

/* Homework Assignment */
data parks;
	set pg2.np_monthlytraffic;
	where ParkName like '%NP';
	Park=substr(ParkName, 1, find(ParkName, "NP") - 2);
	Location=compbl(propcase(Location));
	Gate=tranwrd(Location, 'Traffic Count At ', ' ');
	GateCode = catx('-', ParkCode, Gate);
run;

proc print data=parks;
run;