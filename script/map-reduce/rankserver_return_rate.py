from __future__ import print_function, division
import re, sys, json, time
from collections import defaultdict
from operator import itemgetter

def compile_key(key):
    return re.compile(r' {}:([\d\.-e\+]+?) '.format(key))

def Map(*args):
    exp_pat = re.compile(r'.')
    if args:
        exp_pat = re.compile(r'[:|,|;](%s)[,|;| ]' % args[0])
    compile_key_b = \
        lambda k:re.compile(r' {}:(.*?) '.format(k))
    pat_list = map(compile_key_b, 
                   ['category', 'locations', 'filling'])
    pl_pat = compile_key('platform')
    pat_list.append(pl_pat)
    for line in sys.stdin:
        try:
            assert '[QUERY]' in line
            assert 'ytrs_' not in line
            assert exp_pat.search(line)
            line = json.loads(line.strip())['body']
        except:
            continue
        day, time, body = line.strip().split(' ', 2)
        body += ' '
        ca, locs, fils, pl = [p.findall(body) for p in pat_list]
        fils.append('') # fils maybe empty
        fils_dict = dict([t.split(',') for t in fils[0].split(';') if t])
        for loc in locs[0].split(','):
            level = fils_dict.get(loc, '0') 
            response = int(level != '0')
            print(pl[0], ca[0], loc, sep='*', end='\t')
            print(1, response, level, sep='\t')

def Reduce(*args):
    last_key, req_c, res_c = "", 0, 0
    level_list = [0] * 3
    for line in sys.stdin:
        key, req, res, level = line.strip().split('\t')
        if last_key and last_key != key:
            print(*last_key.split('*'), sep='\t', end='\t')
            print(res_c/req_c, res_c, req_c, sep='\t', end='\t')
            print(*[l/req_c for l in level_list], sep='\t')
            req_c, res_c, level_list = 0, 0, [0] * 3
        res_c += int(res)
        req_c += int(req)
        last_key = key
        if level == '0':continue
        level_list[int(level) - 1] += 1
    if last_key:
        print(*last_key.split('*'), sep='\t', end='\t')
        print(res_c/req_c, res_c, req_c, sep='\t', end='\t')
        print(*[l/req_c for l in level_list], sep='\t')

if __name__ == '__main__':
    globals()[sys.argv[1]](*sys.argv[2:])
