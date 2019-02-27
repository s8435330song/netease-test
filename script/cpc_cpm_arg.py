import sys
f1=open(sys.argv[1],'r')
f2=open(sys.argv[2],'r')
d1={}
d2={}
for l in f1:
    l=l.strip().split('\t')
    if not d1.has_key(d1[l[3]]):
        d1[l[3]] = [l[2],l[0],l[1]]
    else:
        d1[l[3]].append([l[2],l[0],l[1]])


for l in f2:
    l=l.strip().split('\t')
    if not d1.has_key(d1[l[3]]):
        d2[l[2]] = [l[1],l[0]]
    else:
        d2[l[2]].append([l[1],l[0]])

def formdict(list1,list2):
    dict1={}
    dict2={}
    for l in list1:
        dict1[l[2]] = [l[0],l[1]]
    for l in list2:
        dict2[l[1]] = l[0]
    return dict1,dict2





for l in (set(d1.keys()) & set(d2.keys())):
    dic_tmp1,dic_tmp2 = formdict(d1[l],d2[l])
    for ll in (set(dic_tmp1.keys()) & set(dic_tmp2.keys())):
        print dic_tmp1[l][0],dic_tmp1[l][1],dic_tmp2[l][0]
        print "****************************************************************"