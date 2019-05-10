# -*- coding: utf-8 -*-


import pandas as pd
import saspy
import pandas as pd
import sys
import matplotlib.pyplot as plt


# begins SAS Session
sas = saspy.SASsession()
# sas._io.sascfg.encoding = 'latin2'
sas.set_results('pandas')

# SAS encoding is latin2, in spyder is UTF-8, override encoding from SAS
# sas._io.sascfg.encoding = 'override_encoding'
    
# assigning additional SAS libraries
sas.saslib(libref='DEV', path='/home/S1613351/dev')
     
# print all available libraries
list_of_libraries = sorted(sas.assigned_librefs())
for lib in list_of_libraries:
    print(lib)


# loading dataset from local
iris_pd = pd.read_csv('./datasets/iris.csv')

# convert dataset to SAS data
iris = sas.df2sd(iris_pd)

# print first 5 observations
iris.head()

# print last 5 observations
iris.tail()

# display column info
iris.columnInfo()

# list all tables in libraries
sas.list_tables('work', results='pandas')


# convert DataFrame to SAS dataset
df = pd.DataFrame(dict(name=['pawel', 'tomek'], age=[26, 20]))
sas.dataframe2sasdata(df=df, table='sample', libref='work', results='pandas')
sas.dataframe2sasdata(df=df, table='sample_2', libref='dev')

# list tables in library
sas.list_tables('work')
sas.list_tables('dev')

# display information about datasets in library
sas.datasets('work')

# download SAS dataset from remote to local
sas.download(localfile='./datasets/test.sas7bdat',
             remotefile='/home/S1613351/dev/sample.sas7bdat', overwrite=True)

# checking if table exists in library
sas.exist(table='sample_2', libref='dev')
sas.exist(table='sample', libref='dev')

# display some information about file as dictionary
sas.file_info('/home/S1613351/dev/sample.sas7bdat', results='pandas')


# listing tables in library
sas.list_tables('dev', results='pandas')

# laoding SAS data to python
agr = sas.sasdata('sample', libref='dev', results='pandas')
head = agr.head()
columnInfo = agr.columnInfo()

# laoding SAS data to python with dsopts
iris = sas.sasdata(table='iris_df', libref='dev',
                   dsopts={'keep':'sepal_length'})

# convert SAS dataset to a pandas DataFrame
df = sas.sasdata2dataframe(table='iris_df', libref='S1613351', method='csv',
                           dsopts={'where':'petal_width > 0.6',
                                   'keep':'sepal_width petal_width species',
                                   'obs': 10})
    
# print current full contents of the SASLOG
print(sas.saslog())

# submit is using to pass any SAS Code, it returns dictionary with LOG and LST
result_dict = sas.submit(
        '''
        proc print data=S1613351.iris_df;
        run;
        ''', results='pandas')

print(result_dict['LOG'])
print(result_dict['LST'])

# creating macro variables enter by user, prompt option - dict of names:
# falgs to create macro variables
res_dict = sas.submit(
        '''
        proc print data=&libname..&table_name.;
        run;
        ''',
        results='pandas',
        prompt={'libname': True, 'table_name': True})

# name of the macro variable to set
sas.symget('libname')
sas.symget('table_name')

# teach me SAS: on, off
# nosub - boolean, doesn't submit the code, 
# print it out so you can see what SAS code is
sas.teach_me_SAS(nosub=True)
sas.list_tables('dev', results='pandas')
sas.teach_me_SAS(nosub=False)
sas.list_tables('dev', results='pandas')

# ending SAS Session
sas.endsas()

