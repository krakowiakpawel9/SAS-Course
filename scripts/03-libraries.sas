/*
Library is a collection of data files that are the same type and in the same location.
The SAS library is created by libname statement.
The name of the library must have 8 character maximum and starts with letter or underscore
After the library name we specify the engine (set of instructions for reading structured data):
- base - SAS tables (default engine)
- xlsx - Excel
*/
libname lib_test base "/folders/myfolders/SAS-Course/output";

/* good practice is to clear libraries during the work */
libname lib_test clear;
libname pg1 "/folders/myfolders/SAS-Course/data";

/*
Several libraries are defined automatically in the SAS session:
- work - working library (default)
- sashelp - collections of sample tables and other files
- may be other libraries established by the SAS administrator
*/
libname out "/folders/myfolders/SAS-Course/output";

/* This command allows to create permanent SAS table in the location of the 'out' library */
data class_copy_1 out.class_copy_2;
	set sashelp.class;
run;

libname out clear;

/* Using library to read Excel files */
/* Options validvarname allows to unify naming convention, replaces space to underscore and truncates names
greater then 32 characters */
options validvarname=v7;
libname xl_lib xlsx "/folders/myfolders/SAS-Course/data/class.xlsx";

proc print data=xl_lib.class;
run;

libname xl_lib clear;

/* Second example with reading Excel file */
options validvarname=v7;
libname xlstorm xlsx "/folders/myfolders/SAS-Course/data/storm.xlsx";

proc contents data=xlstorm.storm_summary;
run;

libname xlstorm clear;

/* Third example with Excel files */
options validvarname=v7;
libname np xlsx "/folders/myfolders/SAS-Course/data/np_info.xlsx";

proc print data=np.parks(obs=10);
proc print data=np.species(obs=10);
proc print data=np.visits(obs=10);
proc contents data=np.parks;
run;
libname np clear;

