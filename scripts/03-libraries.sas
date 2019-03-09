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