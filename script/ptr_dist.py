import sys
import json
import datetime

fr = open('stdout.2018-12-25','r')

dict_ptr = {}
for l in fr:
    l=json.loads(l.strip())
    dict_ptr.setdefault(l[0], l[1])

tmp =0
interval = 0.1
for j in [i/10.0 for i in range(1,12)]:

    for k in dict_ptr.keys():
        if k < j and k>=j-interval:
            tmp+=dict_ptr[k]
    print j-interval,'~',j,tmp
    tmp=0



