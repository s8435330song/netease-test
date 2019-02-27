#coding=utf-8
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
import json
fr = open(sys.argv[1],'r')
fr2 = open(sys.argv[2],'r')
dict_date0 = {}
dict_date1 = {}
dict_date2 = {}
dict_date10 = {}
for l in fr2:
    l = l.strip().split(',')
    if l[1] == '10':
        dict_date0[l[0]] = [l[2],l[3],l[4]]
    if l[1] == '1':
        dict_date1[l[0]] = [l[2],l[3],l[4]]
    if l[1] == '2':
        dict_date2[l[0]] = [l[2],l[3],l[4]]
    if l[1] == '10':
        dict_date10[l[0]] = [l[2],l[3],l[4]]
#print dict_date0

flag1 = 0
flag2 = 0
flag3 = 0
flag4 = 0
flag5 = 0
flag6 = 0
flag7 = 0
flag8 = 0
flag9 = 0
flag10 = 0
flag000 = 1
flag111 = 0
flag222 = 0
dict1 = {}
dict2 = {}
dict3 = {}
for l in fr:
    if "argument: key(sDt), value(" in l:
        dt = l.strip().strip("argument: key(sDt), value(")
    if "All process is finish" in l:
        break
    if "(1 location_count) all" in l:
        flag1 = 1
        continue

    if "(1 location_count)uniqid_count is 1" in l:
        flag2 = 1
        flag1 = 0
        continue

    if "(1 location_count)uniqid_count #" in l:
        flag3 = 1
        flag1 = 0
        flag2 = 0
        continue

    if "(more location_count)uniqid_count is 1#" in l:
        flag4 = 1
        flag3 = 0
        continue

    if "(more location_count)uniqid_count less than location_count#" in l:
        flag5 = 1
        flag4 = 0
        continue

    if "(more location_count)uniqid_count equal to location_count#" in l:
        flag6 = 1
        flag5 = 0
        continue

    if "(more location_count)uniqid_count more than location_count#" in l:
        flag7 = 1
        flag6 = 0
        continue

    if "(more location_count)uniqid_count 2 times than  location_count#" in l:
        flag8 = 1
        flag7 = 0
        continue

    if "(location_count =10)filter rate#" in l:
        flag9 = 1
        flag8 = 0
        continue

    if "(unique_ids_count greater than location_count )location_count filter rate#" in l:
        flag10 = 1
        flag9 = 0
        continue
    if "1111111111111111111111111111111" in l or "2222222222222222222222222222222" in l:
        flag1 = 0
        flag2 = 0
        flag3 = 0
        flag4 = 0
        flag5 = 0
        flag6 = 0
        flag7 = 0
        flag8 = 0
        flag9 = 0
        flag10 = 0

    if "1111111111111111111111111111111" in l:
        flag111 = 1
        flag000 = 0
    if "2222222222222222222222222222222" in l:
        flag222 = 1
        flag111 = 0
    if flag000:
        if flag1 :
            dict1[3] = l.strip()

        if flag2 :
            dict1[1] = l.strip()

        if flag3 :
            dict1[2] = l.strip()

        if flag4 :
            dict1[4] = l.strip()

        if flag5 :
            dict1[5] = l.strip()

        if flag6 :
            dict1[6] = l.strip()

        if flag7 :
            dict1[7] = l.strip()

        if flag8 :
            dict1[8] = l.strip()

        if flag9 :
            dict1[9] = l.strip()

        if flag10 :
            dict1[10] = l.strip()
    if flag111:
        if flag1 :
            dict2[3] = l.strip()

        if flag2 :
            dict2[1] = l.strip()

        if flag3 :
            dict2[2] = l.strip()

        if flag4 :
            dict2[4] = l.strip()

        if flag5 :
            dict2[5] = l.strip()

        if flag6 :
            dict2[6] = l.strip()

        if flag7 :
            dict2[7] = l.strip()

        if flag8 :
            dict2[8] = l.strip()

        if flag9 :
            dict2[9] = l.strip()

        if flag10 :
            dict2[10] = l.strip()
    if flag222:
        if flag1 :
            dict3[3] = l.strip()

        if flag2 :
            dict3[1] = l.strip()

        if flag3 :
            dict3[2] = l.strip()

        if flag4 :
            dict3[4] = l.strip()

        if flag5 :
            dict3[5] = l.strip()

        if flag6 :
            dict3[6] = l.strip()

        if flag7 :
            dict3[7] = l.strip()

        if flag8 :
            dict3[8] = l.strip()

        if flag9 :
            dict3[9] = l.strip()

        if flag10 :
            dict3[10] = l.strip()

print dict1
print dict2
print dict3


print "时间"+","+"无素材数"+","+"占比"+","+\
        '*********'+","+\
    "一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+\
        '*********'+","+\
    "一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+\
        '*********'+","+\
    "一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+\
        '*********'+","+\
    "一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"


print dt,',',dict_date0[dt][0],',',dict_date0[dt][2],',',\
        '*********',',',\
        dict1.get(1,'999999'),',',float(dict1.get(1,'999999'))/float(dict_date0[dt][1]),',',dict1.get(2,'999999'),',',float(dict1.get(2,'999999'))/float(dict_date0[dt][1]),',',dict1.get(3,'999999'),',',float(dict1.get(3,'999999'))/float(dict_date0[dt][1]),',',dict1.get(4,'999999'),',',float(dict1.get(4,'999999'))/float(dict_date0[dt][1]),',',dict1.get(5,'999999'),',',float(dict1.get(5,'999999'))/float(dict_date0[dt][1]),',',dict1.get(6,'999999'),',',float(dict1.get(6,'999999'))/float(dict_date0[dt][1]),',',dict1.get(7,'999999'),',',float(dict1.get(7,'999999'))/float(dict_date0[dt][1]),',',dict1.get(8,'999999'),',',float(dict1.get(8,'999999'))/float(dict_date0[dt][1]),',',\
        '*********',',',\
        dict2[1],',',float(dict2[1])/float(dict_date1[dt][1]),',',dict2[2],',',float(dict2[2])/float(dict_date1[dt][1]),',',dict2[3],',',float(dict2[3])/float(dict_date1[dt][1]),',',dict2[4],',',float(dict2[4])/float(dict_date1[dt][1]),',',dict2[5],',',float(dict2[5])/float(dict_date1[dt][1]),',',dict2[6],',',float(dict2[6])/float(dict_date1[dt][1]),',',dict2[7],',',float(dict2[7])/float(dict_date1[dt][1]),',',dict2[8],',',float(dict2[8])/float(dict_date1[dt][1]),',',\
        '*********',',',\
        dict3[1],',',float(dict3[1])/float(dict_date2[dt][1]),',',dict3[2],',',float(dict3[2])/float(dict_date2[dt][1]),',',dict3[3],',',float(dict3[3])/float(dict_date2[dt][1]),',',dict3[4],',',float(dict3[4])/float(dict_date2[dt][1]),',',dict3[5],',',float(dict3[5])/float(dict_date2[dt][1]),',',dict3[6],',',float(dict3[6])/float(dict_date2[dt][1]),',',dict3[7],',',float(dict3[7])/float(dict_date2[dt][1]),',',dict3[8],',',float(dict3[8])/float(dict_date2[dt][1])

