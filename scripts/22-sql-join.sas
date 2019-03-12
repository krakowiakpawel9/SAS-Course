/* Manipulating data using SQL */
data first;
input id name $;
datalines;
1 pawel
2 tomek
3 marian
4 adam
;
run;

data second;
input id age;
datalines;
1 27
2 22
3 30
5 40
;
run;

proc sql;
select * from first;
select * from second;
quit;

proc sql;
select * from first f inner join second s on f.id = s.id;
select * from first f left join second s on f.id = s.id;
select * from first f right join second s on f.id = s.id order by age desc;
select * from first f cross join second;
quit;
