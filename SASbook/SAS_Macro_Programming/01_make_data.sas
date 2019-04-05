data bookdb;
	attrib section length=$30 label='Section'
		booktitle length=$50 label='Title of Book'
		author length=$50 label='First Author'
		publisher length=$50 label='Publisher'
		cost length=8 label='Wholesale Cost' format=dollar10.2
		listprice length=8 label='List Price' format=dollar10.2
		saleprice length=8 label='Sale Price' format=dollar10.2;
	array sname{6} $ 30 ('Internet'
		'Networks and Telecommunication'
		'Operating Systems'
		'Programming and Applications'
		'Certification and Training'
		'Web Design');
	array ln{125} $ 15 _temporary_ (
		'Smith ' 'Johnson ' 'Williams ' 'Jones '
		'Brown ' 'Davis ' 'Miller ' 'Wilson '
		'Moore ' 'Taylor ' 'Anderson ' 'Thomas '
		'Jackson ' 'White ' 'Harris ' 'Martin '
		'Thompson ' 'Garcia ' 'Martinez ' 'Robinson '
		'Clark ' 'Rodriguez ' 'Lewis ' 'Lee '
		'Walker ' 'Hall ' 'Allen ' 'Young '
		'Hernandez ' 'King ' 'Wright ' 'Lopez '
		'Hill ' 'Scott ' 'Green ' 'Adams '
		'Baker ' 'Gonzalez ' 'Nelson ' 'Carter '
		'Mitchell ' 'Perez ' 'Roberts ' 'Turner '
		'Phillips ' 'Campbell ' 'Parker ' 'Evans '
		'Edwards ' 'Collins ' 'Stewart ' 'Sanchez '
		'Morris ' 'Rogers ' 'Reed ' 'Cook '
		'Morgan ' 'Bell ' 'Murphy ' 'Bailey '
		'Rivera ' 'Cooper ' 'Richardson ' 'Cox '
		'Howard ' 'Ward ' 'Torres ' 'Peterson '
		'Gray ' 'Ramirez ' 'James ' 'Watson '
		'Brooks ' 'Kelly ' 'Sanders ' 'Price '
		'Bennett ' 'Wood ' 'Barnes ' 'Ross '
		'Henderson ' 'Coleman ' 'Jenkins ' 'Perry '
		'Powell ' 'Long ' 'Patterson ' 'Hughes '
		'Flores ' 'Washington ' 'Butler ' 'Simmons '
		'Foster ' 'Gonzales ' 'Bryant ' 'Alexander '
		'Russell ' 'Griffin ' 'Diaz ' 'Hayes '
		'Myers ' 'Ford ' 'Hamilton ' 'Graham '
		'Sullivan ' 'Wallace ' 'Woods ' 'Cole '
		'West ' 'Jordan ' 'Owens ' 'Reynolds '
		'Fisher ' 'Ellis ' 'Harrison ' 'Gibson '
		'Mcdonald ' 'Cruz ' 'Marshall ' 'Ortiz '
		'Gomez ' 'Murray ' 'Freeman ' 'Wells '
		'Webb ');
	array fn{70} $ 11 _temporary_ (
		'James ' 'John ' 'Robert ' 'Michael '
		'William ' 'David ' 'Richard ' 'Charles '
		'Joseph ' 'Thomas ' 'Christopher' 'Daniel '
		'Paul ' 'Mark ' 'Donald ' 'George '
		'Kenneth ' 'Steven ' 'Edward ' 'Brian '
		'Ronald ' 'Anthony ' 'Kevin ' 'Jason '
		'Matthew ' 'Gary ' 'Timothy ' 'Jose '
		'Larry ' 'Jeffrey ' 'Jacob ' 'Joshua '
		'Ethan ' 'Andrew ' 'Nicholas '
		'Mary ' 'Patricia ' 'Linda ' 'Barbara '
		'Elizabeth ' 'Jennifer ' 'Maria ' 'Susan '
		'Margaret ' 'Dorothy ' 'Lisa ' 'Nancy '
		'Karen ' 'Betty ' 'Helen ' 'Sandra '
		'Donna ' 'Carol ' 'Ruth ' 'Sharon '
		'Michelle ' 'Laura ' 'Sarah ' 'Kimberly '
		'Deborah ' 'Jessica ' 'Shirley ' 'Cynthia '
		'Angela ' 'Melissa ' 'Emily ' 'Hannah '
		'Emma ' 'Ashley ' 'Abigail ');
	array pubname{12} $ 30 ('AMZ Publishers' 'Technology Smith'
		'Mainst Media' 'Nifty New Books'
		'Wide-World Titles'
		'Popular Names Publishers' 'Eversons Books'
		'Professional House Titles'
		'IT Training Texts' 'Bookstore Brand Titles'
		'Northern Associates Titles'
		'Doe&Lee Ltd.');
	array prices{13} p1-p13
		(27,30,32,34,36,40,44,45,50,54,56,60,86);
	array smax{6} (850,450,555,890,470,500);
	keep section booktitle author publisher listprice saleprice cost;

	do i=1 to 6;
		section=sname{i};
		sectionmax=smax{i};

		do j=1 to sectionmax;
			booktitle=catx(' ',section,'Title',put(j,4.));
			lnptr=round(125*(uniform(54321)),1.);

			if lnptr=0 then
				lnptr=125;
			author=cats(ln{lnptr},',');
			fnptr=round(70*(uniform(12345)),1.);

			if fnptr=0 then
				fnptr=70;
			author=catx(' ',author,fn{fnptr});
			pubptr=round(12*(uniform(7890)),1.);

			if pubptr=0 then
				pubptr=12;
			publisher=pubname{pubptr};
			pval=round(2*normal(3),1) + 7;

			if pval > 13 then
				pval=13;
			else if pval < 1 then
				pval=1;
			listprice=prices{pval} + .95;
			saleprice=listprice;

			if mod(j,8)=0 then
				saleprice=listprice*.9;

			if mod(j,17)=0 and mod(j,8) ne 0 then
				saleprice=listprice*.8;
			cost=.5*listprice;

			if mod(j,12)=0 then
				cost=.6*listprice;
			ncopies=round(rangam(33,.5),1);

			do n=1 to ncopies;
				output;
			end;

			output;
		end;
	end;
run;

data ytdsales(label='Sales for 2007');
	keep section--saleprice;
	attrib section length=$30 label='Section'
		saleid length=8 label='Sale ID' format=8.
		saleinit length=$3 label='Sales Person Initials'
		datesold length=4 label='Date Book Sold' format=mmddyy10. informat=mmddyy10.
		booktitle length=$50 label='Title of Book'
		author length=$50 label='First Author'
		publisher length=$50 label='Publisher'
		cost length=8 label='Wholesale Cost' format=dollar10.2
		listprice length=8 label='List Price' format=dollar10.2
		saleprice length=8 label='Sale Price' format=dollar10.2;
	array mos{12} _temporary_
		(555,809,678,477,300,198,200,500,655,719,649,356);
	array momax{12} momax1-momax12
		(30,27,30,29,30,29,30,30,29,30,29,30);
	array inits{7} $ 3 _temporary_
		('MJM' 'BLT' 'JMB' 'JAJ' 'LPL' 'SMA' 'CAD');
	retain saleid 10000000;

	do m=1 to 12;
		do j=1 to mos{m};
			day=round(momax{m}*uniform(3),1)+1;
			datesold=mdy(m,day,2007);
			obsno=int(uniform(3929)*5366)+1;
			set bookdb point=obsno;
			person=mod(day,7)+1;
			saleinit=inits{person};
			saleid+1;
			output;
		end;

		if m=12 then
			stop;
	end;
run;
