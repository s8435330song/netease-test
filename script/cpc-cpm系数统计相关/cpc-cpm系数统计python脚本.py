f1=open('cpc_category_clean','r')
f2=open('cpm_category_clean','r')
d1={}
d2={}
for l in f1:
 l=l.strip().split(' ')
 d1[l[2]] = [l[0],l[1]]


for l in f2:
 l=l.strip().split(' ')
 d2[l[1]] = [l[0]]


for l in (set(d1.keys()) & set(d2.keys())):
 print d1[l][0],d1[l][1],d2[l][0]




f1=open('cpc_category_clean','r')
f2=open('cpm_category_clean','r')
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

def formdict():




for l in (set(d1.keys()) & set(d2.keys())):
 print d1[l][0],d1[l][1],d2[l][0]