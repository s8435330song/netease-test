import sys
import datetime

fr = open('stdout.20180901','r')

dict_loc = {}
dict_count = {}
sp_k = '1'
for l in fr:
    if l.strip().split('-')[0] == '2018':
        #print dict_loc,dict_count
        #for key in map(str,sorted(map(int,dict_loc.keys()))):
        #    print key,'#',round(dict_loc[key]/float(dict_count[key]),4)
        if dict_loc.has_key(sp_k):
            print str(datetime.datetime.strptime(l.strip(),"%Y-%m-%d")- datetime.date.resolution*1)[0:10],'#',sp_k,'#',round(dict_loc[sp_k]/float(dict_count[sp_k]),4)
        #print '\n'
        #print l.strip()
        dict_loc = {}
        dict_count = {}
        continue
    if len(l.strip().split(','))< 2:
        continue
    #print l.strip()+"*********",len(l.strip().split(','))
    list_tmp = l.strip().split(',')
    if  dict_loc.has_key(list_tmp[0]):
        dict_loc[list_tmp[0]] += float(list_tmp[1])*float(list_tmp[2])
        dict_count[list_tmp[0]] += float(list_tmp[2])
    else:
        #print list_tmp[0]
        #print list_tmp[2]
        dict_loc[list_tmp[0]] = float(list_tmp[2])
        dict_count[list_tmp[0]] = float(list_tmp[2])     
        #print l

