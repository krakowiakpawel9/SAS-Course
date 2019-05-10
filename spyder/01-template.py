# -*- coding: utf-8 -*-

import saspy
import pandas as pd


# begins SAS Session
sas = saspy.SASsession()
# sas._io.sascfg.encoding = 'latin2'
sas.set_results('pandas')
    
# assigning additional SAS libraries
sas.saslib(libref='SAMPLE_NAME', path='path/to/the/library/')
sas.saslib(libref='DEV', path='/home/S1613351/dev')

# print all available libraries
list_of_libraries = sorted(sas.assigned_librefs())
for lib in list_of_libraries:
    print(lib)
    
# end sas session
sas.endsas()
