/* Putlog allows to make simple debugging process if you don't have access to EG */
data myclass;
	set sashelp.class(obs=3);
	putlog "PDV after set statement";
	putlog _all_;
	putlog name;
run;

data test;
	input id name $;
	putlog "After input statement";
	putlog _all_;
	datalines;
1 pawel
2 tomek
3 rysiu
;
run;
