# -*- coding: utf-8 -*-
"""
Created on Tue Apr 28 20:21:49 2015

@author: USF
"""
import numpy as np
import pandas as pd
'''
cd
cd Documents/MSANClasses/InformationVisualization
'''
gtd = pd.read_csv('gtd_06to13_0814dist.csv')
all_gtd = pd.read_csv('gtd_0814dist.csv')

l = list(all_gtd.columns.values)
len(l)

col_num = {}
for i in range(len(l)):
    col_num[l[i]] = i
    
wanted_columns = ['iday','imonth','iyear','country_txt','region_txt','city',
                  'longitude','latitude','attacktype1_txt','nkill','nwound']
npgtd = np.array(all_gtd)

data = npgtd[:,[col_num[c] for c in wanted_columns]]

filtered = np.array(filter(lambda x: x[6] >= 0 or x[6] <= 0, data))
filtered2 = filter(lambda x: x[9] + x[10] > 30, filtered)
filtered3 = np.array(filter(lambda x: x[0] > 0 and x[1] > 0 and x[2] > 0,
                            filtered2))
filtered4 = np.array(filter(lambda x: x[8] != 'Unknown', filtered3))

date = map(lambda x: '-'.join([str(x[1]), str(x[0]), str(x[2])]), filtered4)
z = zip(date,filtered4)
final_data = [np.append(atk[1][3:11],atk[0])for atk in zip(date,filtered4)]

header = ['Country','Region','City','Longitude','Latitude','attacktype',
          'nkill','nwound','Date']
          
df = pd.DataFrame(final_data, columns = header)
df.to_csv('data.csv')

d = {}
for i in final_data:
    try:
        d[i[5]] += 1
    except:
        d[i[5]] = 1
deaths = {}
for i in final_data:
    try:
        deaths[i[5]] += i[6]
    except:
        deaths[i[5]] = i[6]
wounded = {}
for i in final_data:
    try:
        wounded[i[5]] += i[7]
    except:
        wounded[i[5]] = i[7]
country = {}
for i in final_data:
    try:
        country[i[0]] += 1
    except:
        country[i[0]] = 1
