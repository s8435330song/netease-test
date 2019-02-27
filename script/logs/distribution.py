import sys
import json
fr = open(sys.argv[1],'r')
flag1 = 0
flag2 = 0
flag3 = 0
dict1 = {}
dict2 = {}
dict3 = {}
for l in fr:
    if "Filter stat" in l:
        flag2 =0
        break
    if "size-distribution" in l:
        flag1 = 1
        flag3 = 0
        continue
    if "size-average" in l:
        flag1 = 0
    if flag1 :
        l = json.loads(l.strip())
        dict1[l[0]] = l[1]
    if " unique_ids_count distribution" in l:
        flag2 = 1
        continue
    if flag2:
        l = json.loads(l.strip())
        dict2[l[0]] = l[1]

    if "location****" in l:
        flag3 = 1
        continue
    if flag3:
        l = json.loads(l.strip())
        dict3[l[0]] = l[1]

#sum1 = sum(dict1.values())
#sum2 = sum(dict2.values())
#sum3 = sum(dict3.values())
sum1 = 179089468
sum2 = 179089468
sum3 = 179089468


###1-size distribution
print "1-size distribution*********************************************************************************"
for i in dict1.keys():
    print i,",",dict1[i],",","{0}%".format(round(float(dict1[i])*100/sum1,4))

print "unique_ids_count distribution*********************************************************************************"
##unique_ids_count distribution
for i in dict2.keys():
    print i,",",dict2[i],",","{0}%".format(round(float(dict2[i])*100/sum2,4))

print "locationId dimension*********************************************************************************"

#locationId维度
for i in sorted(dict3.keys()):
    print i,",",dict3[i],",","{0}%".format(round(float(dict3[i])*100/sum3,4))
