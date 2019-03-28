proc import 
		datafile="/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/MPI_national.csv" 
		out=mpi dbms=csv replace;
run;

proc print data=mpi;
run;

data mpi_next;
	set mpi;
	keep together Country ISO MPI_Urban Headcount_Ratio_Urban 
		Intensity_of_Deprivation_Urban MPI_Rural Headcount_Ratio_Rural 
		Intensity_of_Deprivation_Rural diff;
	if ISO = 'NIG' then ISO = 'NGA';
	diff = MPI_Urban - MPI_Rural;
	together = catx(',', Country, ISO);
	where  Intensity_of_Deprivation_Rural ge 40;
run;

proc print data=mpi_next;
run;

proc contents data=mpi_next;
run;