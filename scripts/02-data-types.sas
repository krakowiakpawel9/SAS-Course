/*
Column has three attributes:
- Name (1-32 character, starts with letter or underscore)
- Type (Character, Numeric - including Date, SAS stores dates as number of days from 01JAN1960)
- Length (number of bytes allocated to store numeric values, Numeric 8 bytes (~16 significant digits),
Character 1-32767 bytes 1 byte=one character)

proc contents procedure creates a report of the descriptor portion of the table
Number of rows and columns, list of variables
Numeric missing values is represented by period, and Character missing values is represented by space
*/
proc contents 
		data="/folders/myfolders/SAS-Course/data/class_birthdate.sas7bdat";
run;

proc contents data=sashelp.cars;
run;

proc contents data=sashelp.class;
run;