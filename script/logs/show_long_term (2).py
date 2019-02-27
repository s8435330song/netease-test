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
    if l[1] == '0':
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
flag333 = 0
dict1 = {}
dict2 = {}
dict3 = {}
dict4 = {}
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

    if "old aglo rate#" in l:
        flag9 = 1
        flag8 = 0
        continue

    if "(unique_ids_count greater than location_count )location_count filter rate#" in l:
        flag10 = 1
        flag9 = 0
        continue
    if "1111111111111111111111111111111" in l or "2222222222222222222222222222222" in l or "10101010101010101010101010101010" in l:
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
    if "10101010101010101010101010101010" in l:
        flag333 = 1
        flag222 = 0

    if flag000:
        if flag1 :
            dict1[3] = l.strip()
            flag1 = 0

        if flag2 :
            dict1[1] = l.strip()
            flag2 = 0

        if flag3 :
            dict1[2] = l.strip()
            flag3 = 0

        if flag4 :
            dict1[4] = l.strip()
            flag4 = 0

        if flag5 :
            dict1[5] = l.strip()
            flag5 = 0

        if flag6 :
            dict1[6] = l.strip()
            flag6 = 0

        if flag7 :
            dict1[7] = l.strip()
            flag7 = 0

        if flag8 :
            dict1[8] = l.strip()
            flag8 = 0

        if flag9 :
            dict1[9] = json.loads(l.strip())[1]
            flag9 = 0

        if flag10 :
            dict1[10] = l.strip()
            lag10 = 0
    if flag111:
        if flag1 :
            dict2[3] = l.strip()
            flag1 = 0

        if flag2 :
            dict2[1] = l.strip()
            flag2 = 0

        if flag3 :
            dict2[2] = l.strip()
            flag3 = 0

        if flag4 :
            dict2[4] = l.strip()
            flag4 = 0

        if flag5 :
            dict2[5] = l.strip()
            flag5 = 0

        if flag6 :
            dict2[6] = l.strip()
            flag6 = 0

        if flag7 :
            dict2[7] = l.strip()
            flag7 = 0

        if flag8 :
            dict2[8] = l.strip()
            flag8 = 0

        if flag9 :
            dict2[9] = json.loads(l.strip())[1]
            flag9 = 0

        if flag10 :
            dict2[10] = l.strip()
            lag10 = 0
    if flag222:
        if flag1 :
            dict3[3] = l.strip()
            flag1 = 0

        if flag2 :
            dict3[1] = l.strip()
            flag2 = 0

        if flag3 :
            dict3[2] = l.strip()
            flag3 = 0

        if flag4 :
            dict3[4] = l.strip()
            flag4 = 0

        if flag5 :
            dict3[5] = l.strip()
            flag5 = 0

        if flag6 :
            dict3[6] = l.strip()
            flag6 = 0

        if flag7 :
            dict3[7] = l.strip()
            flag7 = 0

        if flag8 :
            dict3[8] = l.strip()
            flag8 = 0

        if flag9 :
            dict3[9] = json.loads(l.strip())[1]
            flag9 = 0

        if flag10 :
            dict3[10] = l.strip()
            lag10 = 0
    if flag333:
        if flag1 :
            dict4[3] = l.strip()
            flag1 = 0

        if flag2 :
            dict4[1] = l.strip()
            flag2 = 0

        if flag3 :
            dict4[2] = l.strip()
            flag3 = 0

        if flag4 :
            dict4[4] = l.strip()
            flag4 = 0

        if flag5 :
            dict4[5] = l.strip()
            flag5 = 0

        if flag6 :
            dict4[6] = l.strip()
            flag6 = 0

        if flag7 :
            dict4[7] = l.strip()
            flag7 = 0

        if flag8 :
            dict4[8] = l.strip()
            flag8 = 0

        if flag9 :
            dict4[9] = json.loads(l.strip())[1]
            flag9 = 0

        if flag10 :
            dict4[10] = l.strip()
            lag10 = 0

#print dict1
#print dict2
#print dict3
#print dict4


print "时间"+","+\
       '*********'+","+\
   "0无素材数"+","+"(无素材数)占比"+","+"一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+"多个广告位总数"+","+"(多个广告位总数)占比"+","+"多个广告位时多个后候选素材的平均填充率"+","+\
       '*********'+","+\
   "1无素材数"+","+"(无素材数)占比"+","+"一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+"多个广告位总数"+","+"(多个广告位总数)占比"+","+"多个广告位时多个后候选素材的平均填充率"+","+\
       '*********'+","+\
   "2无素材数"+","+"(无素材数)占比"+","+"一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+"多个广告位总数"+","+"(多个广告位总数)占比"+","+"多个广告位时多个后候选素材的平均填充率"+","+\
       '*********'+","+\
   "10无素材数"+","+"(无素材数)占比"+","+"一个候选素材(一个广告位)"+","+"(一个候选素材)占比"+","+"多个候选素材(一个广告位)"+","+"(多个候选素材)占比"+","+"一个广告总数"+","+"(一个广告总数)占比"+","+"等于1"+","+"(等于1)占比"+","+"小于"+","+"(小于)占比"+","+"等于"+","+"(等于)占比"+","+"大于"+","+"(大于)占比"+","+"大于2倍"+","+"(大于2倍)占比"+","+"多个广告位总数"+","+"(多个广告位总数)占比"+","+"多个广告位时多个后候选素材的平均填充率"


print dt,',',\
        '*********',',',\
        dict_date0[dt][0],',',dict_date0[dt][2],',',dict1.get(1,'999999'),',',float(dict1.get(1,'999999'))/float(dict_date0[dt][1]),',',dict1.get(2,'999999'),',',float(dict1.get(2,'999999'))/float(dict_date0[dt][1]),',',dict1.get(3,'999999'),',',float(dict1.get(3,'999999'))/float(dict_date0[dt][1]),',',dict1.get(4,'999999'),',',float(dict1.get(4,'999999'))/float(dict_date0[dt][1]),',',dict1.get(5,'999999'),',',float(dict1.get(5,'999999'))/float(dict_date0[dt][1]),',',dict1.get(6,'999999'),',',float(dict1.get(6,'999999'))/float(dict_date0[dt][1]),',',dict1.get(7,'999999'),',',float(dict1.get(7,'999999'))/float(dict_date0[dt][1]),',',dict1.get(8,'999999'),',',float(dict1.get(8,'999999'))/float(dict_date0[dt][1]),',',int(dict1[5])+int(dict1[6])+int(dict1[7]),',',(int(dict1[5])+int(dict1[6])+int(dict1[7]))/float(dict_date0[dt][1]),',',dict1[9],',',\
        '*********',',',\
        dict_date1[dt][0],',',dict_date1[dt][2],',',dict2[1],',',float(dict2[1])/float(dict_date1[dt][1]),',',dict2[2],',',float(dict2[2])/float(dict_date1[dt][1]),',',dict2[3],',',float(dict2[3])/float(dict_date1[dt][1]),',',dict2[4],',',float(dict2[4])/float(dict_date1[dt][1]),',',dict2[5],',',float(dict2[5])/float(dict_date1[dt][1]),',',dict2[6],',',float(dict2[6])/float(dict_date1[dt][1]),',',dict2[7],',',float(dict2[7])/float(dict_date1[dt][1]),',',dict2[8],',',float(dict2[8])/float(dict_date1[dt][1]),',',int(dict2[5])+int(dict2[6])+int(dict2[7]),',',(int(dict2[5])+int(dict2[6])+int(dict2[7]))/float(dict_date1[dt][1]),',',dict2[9],',',\
        '*********',',',\
        dict_date2[dt][0],',',dict_date2[dt][2],',',dict3[1],',',float(dict3[1])/float(dict_date2[dt][1]),',',dict3[2],',',float(dict3[2])/float(dict_date2[dt][1]),',',dict3[3],',',float(dict3[3])/float(dict_date2[dt][1]),',',dict3[4],',',float(dict3[4])/float(dict_date2[dt][1]),',',dict3[5],',',float(dict3[5])/float(dict_date2[dt][1]),',',dict3[6],',',float(dict3[6])/float(dict_date2[dt][1]),',',dict3[7],',',float(dict3[7])/float(dict_date2[dt][1]),',',dict3[8],',',float(dict3[8])/float(dict_date2[dt][1]),',',int(dict3[5])+int(dict3[6])+int(dict3[7]),',',(int(dict3[5])+int(dict3[6])+int(dict3[7]))/float(dict_date2[dt][1]),',',dict3[9],',',\
        '*********',',',\
        dict_date10[dt][0],',',dict_date10[dt][2],',',dict4[1],',',float(dict4[1])/float(dict_date10[dt][1]),',',dict4[2],',',float(dict4[2])/float(dict_date10[dt][1]),',',dict4[3],',',float(dict4[3])/float(dict_date10[dt][1]),',',dict4[4],',',float(dict4[4])/float(dict_date10[dt][1]),',',dict4[5],',',float(dict4[5])/float(dict_date10[dt][1]),',',dict4[6],',',float(dict4[6])/float(dict_date10[dt][1]),',',dict4[7],',',float(dict4[7])/float(dict_date10[dt][1]),',',dict4[8],',',float(dict4[8])/float(dict_date10[dt][1]),',',int(dict4[5])+int(dict4[6])+int(dict4[7]),',',(int(dict4[5])+int(dict4[6])+int(dict4[7]))/float(dict_date10[dt][1]),',',dict4[9]

