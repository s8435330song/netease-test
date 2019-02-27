import sys
f1=open(sys.argv[1],'r')
d1={}
for l in f1:
    l = json.loads(l.strip())
    if d1.has_key(d1[l["adplan_id"]]):
        d1[l["adplan_id"]].append(l["scheduling_id"])
    else:
        d1[l["adplan_id"]] = l["scheduling_id"]

json.dump(d1)