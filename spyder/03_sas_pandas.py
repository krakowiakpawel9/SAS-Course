# -*- coding: utf-8 -*-

import saspy
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np


# %% begins SAS Session
sas = saspy.SASsession()
# sas._io.sascfg.encoding = 'latin2'
sas.set_results('pandas')
    
# assigning additional SAS libraries
# sas.saslib(libref='SAMPLE_NAME', path='path/to/the/library/')
sas.saslib(libref='DEV', path='/home/S1613351/dev')

# print all available libraries
list_of_libraries = sorted(sas.assigned_librefs())
for lib in list_of_libraries:
    print(lib)

# %% sas way
# it works only with remote server path
cars = sas.sasdata(table='cars', libref='sashelp')
instructions = [name for name in dir(cars) if not name.startswith('_')]
cars_col_info = cars.columnInfo()
cars_contents = cars.contents()
cars_describe = cars.describe()
cars_info_ = cars.info()
cars.to_csv('/home/S1613351/dev/cars.csv')

# %% pandas way
cars_df = sas.sd2df_CSV(table='cars', libref='sashelp')
# cars_df['MSRP'].hist(bins=20)
# cars_df.hist(column='MSRP', by='Origin')

col_names = [col_name for col_name in cars_df.columns]

# convert to array
cars_arr = cars_df.values

# display basic statistics
cars_desc = cars_df.describe()

# transpose dataframe
cars_df_T = cars_df.T

# sorting by an axis
cars_df.sort_index(axis=1, ascending=False)

# sorting by values
cars_df.sort_values(by='Make')
cars_by_origin_msrp = cars_df.sort_values(by=['Origin', 'MSRP'],
                                          ascending=[True, False],
                                          na_position='last')

# extract manually some columns
cars_extract = cars_df.loc[:, ['Make', 'Origin', 'MSRP']]
# cars_extract.hist(by='Origin')

# boolean indexing
cars_df_over_20000 = cars_df[cars_df['MSRP'] > 20000]
origin = list(cars_df['Origin'].unique())

# using isin()
origin_usa = cars_df[cars_df['Origin'].isin(['USA'])]
suv_sedan = cars_df[cars_df['Type'].isin(['SUV', 'Sedan'])].\
                    sort_values(by=['Type'])

# %% missing data
df = sas.sd2df_CSV(table='cars', libref='sashelp')

# drop any rows that have missing data
df_drop = df.dropna(how='any')

# fill missing value
df_fill = df.fillna(value=0)

# get boolean mask where values are nan
df_mask = pd.isnull(df)

# %% operations
df.info()
df.mean()

# shift values one row down
print(df.shift())

# shift values one row down and fill nan values 
# print(df.shift(periods=1, fill_value=0))

# shift values two rows down
print(df.shift(2))

# shift values one column to right
print(df.shift(axis=1))

# apply function
print(df['MSRP'])

df['MSRP'].apply(lambda x: x / 1000.)
df['MSRP'].apply(lambda x: (x - df['MSRP'].mean()) / df['MSRP'].std())

# %% histogram, discretization

count_make = df['Make'].value_counts()
count_origin = df['Origin'].value_counts()
# count_origin.plot.pie()

# discretize continuous values 
bin_msrp = df['MSRP'].value_counts(bins=20)
bin_msrp.hist(bins=20)

# %% merging and concatenating 

df_1 = df[:10]
df_2 = df[10:20]
df_3 = df[20:30]

# concatenating by index
pd.concat([df_1, df_2, df_3], axis=0)

df_A = df['Origin'][:10]
df_B = df['Make'][:10]

# concatenating by column
pd.concat([df_A, df_B], axis=1)

df_x = pd.DataFrame({'stock' : ['google', 'amazon'], 'price': [100, 250]})
df_y = pd.DataFrame({'stock' : ['google', 'amazon'], 'volume': [2000, 40000]})

pd.merge(df_x, df_y, on='stock')

# %% group by

df.groupby('Make').sum()
df.groupby('Origin').sum()
multi_group = df[['Origin', 'Type', 'MSRP']].groupby(['Origin', 'Type']).mean()


# %% end sas session
sas.endsas()
