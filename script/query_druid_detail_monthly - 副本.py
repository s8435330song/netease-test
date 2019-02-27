#-*-coding:utf-8-*-

import requests
import ConfigParser
from datetime import date, timedelta, datetime
import calendar
import os
import sys
import json


def format_str(d, num):
    return ('%.'+ str(num) +'f') % d

def calc_diff(compare_val, base_val):
    try:
        compare_val = float(compare_val)
        base_val = float(base_val)
    except:
        return "NULL"
    if(base_val > 0):
        return str('%.2f' % ((compare_val- base_val) / base_val * 100)) + '%'
    else:
        return "NULL"


def get_filter(start_date, exp, site, category, location, cost_type=None):
    date = datetime.strptime(start_date, "%Y-%m-%d") + timedelta(days=1)
    next_date = date.strftime("%Y-%m-%d")
    # deal query json
    input_json_file = open('conf/query_model.json', 'r')
    input_json = json.loads(input_json_file.read())
    input_json['intervals'] = [start_date + '/' + next_date]
    input_json['filter'] = {
        "type": "and",
        "fields": [
            {
                "type": "regex",
                "dimension": "strategy",
                "pattern": "^"+exp+"$|^"+exp+",|^"+exp+";|,"+exp+",|;"+exp+";|,"+exp+";|;"+exp+",|,"+exp+"$|;"+exp+"$"
            },
            {
                "type": "selector",
                "dimension": "site",
                "value": site
            },
            {
                "type": "selector",
                "dimension": "category",
                "value": category
            },
            {
                "type": "selector",
                "dimension": "location",
                "value": location
            }
        ]
    }
    if cost_type and cost_type == 'cpc':
        input_json['filter']['fields'].append({"type": "selector","dimension": "cost_type","value": 1})
    # send request
    url = 'http://10.120.180.208:8082/druid/v2/?pretty'
    params_str = json.dumps(input_json)
    headers = {'content-type': 'application/json'}
    r = requests.post(url, headers=headers, data=params_str)
    input_json_file.close()
    return r.json()


def get_article_comb():
    article_location_comb_file = open('conf/article_location.txt', 'r')
    article_location_comb = {}
    for line in article_location_comb_file:
        parts = line.strip().split()
        if len(parts) == 6:
            key = parts[0]
            site = parts[1]
            category = parts[2]
            location = parts[3]
            if key and site and category and location:
                tmp_comb = {'site': site, 'category': category,
                            'location': location}
                if key not in article_location_comb:
                    article_location_comb[key] = []
                article_location_comb[key].append(tmp_comb)
    article_location_comb_file.close()
    return article_location_comb


def deal_data(start_dt, cpc_dic, all_dic, result_file, exp, exp_dz):
    result_data_file = open(result_file, 'w')

    exp_cpc_dic = {}
    exp_all_dic = {}

    # compute cpc
    for key, value in cpc_dic.items():
        for v in value:
            event = v['event']
            if not event:
                continue
            if key not in exp_cpc_dic:
                exp_cpc_dic[key] = event
            else:
                pv = exp_cpc_dic[key]['impression']
                clk = exp_cpc_dic[key]['click']
                exp_cpc_dic[key]['impression'] += event['impression']
                exp_cpc_dic[key]['show_acb1'] += event['show_acb1']
                exp_cpc_dic[key]['click'] += event['click']
                exp_cpc_dic[key]['pclick'] += event['pclick']
                exp_cpc_dic[key]['click_acb1'] += event['click_acb1']
                exp_cpc_dic[key]['charge'] += event['charge']
                exp_cpc_dic[key]['ctr'] = float(exp_cpc_dic[key]['click']) / float(exp_cpc_dic[key]['impression'])
                if exp_cpc_dic[key]['impression'] > 0:
                    exp_cpc_dic[key]['ecpm'] = float(exp_cpc_dic[key]['charge']*1000) / float(exp_cpc_dic[key]['impression'])
                    exp_cpc_dic[key]['pctr'] = float(exp_cpc_dic[key]['pclick']) / float(exp_cpc_dic[key]['impression'])
                    exp_cpc_dic[key]['show_acb'] = float(exp_cpc_dic[key]['show_acb1']) / float(exp_cpc_dic[key]['impression'])

                if exp_cpc_dic[key]['click'] > 0:
                    exp_cpc_dic[key]['acp'] = float(exp_cpc_dic[key]['charge']) / float(exp_cpc_dic[key]['click'])
                    exp_cpc_dic[key]['click_acb'] = float(exp_cpc_dic[key]['click_acb1']) / float(exp_cpc_dic[key]['click'])
                if exp_cpc_dic[key]['click_acb1'] > 0:
                    exp_cpc_dic[key]['click_price_bid'] = float(exp_cpc_dic[key]['charge']) / float(exp_cpc_dic[key]['click_acb1'])

    # compute all
    for key, value in all_dic.items():
        for v in value:
            event = v['event']
            if not event:
                continue
            if key not in exp_all_dic:
                exp_all_dic[key] = event
            else:
                pv = exp_all_dic[key]['impression']
                clk = exp_all_dic[key]['click']
                exp_all_dic[key]['impression'] += event['impression']
                exp_all_dic[key]['show_acb1'] += event['show_acb1']
                exp_all_dic[key]['click'] += event['click']
                exp_all_dic[key]['pclick'] += event['pclick']
                exp_all_dic[key]['click_acb1'] += event['click_acb1']
                exp_all_dic[key]['charge'] += event['charge']
                exp_all_dic[key]['ctr'] = float(exp_all_dic[key]['click']) / float(exp_all_dic[key]['impression'])
                if exp_all_dic[key]['impression'] > 0:
                    exp_all_dic[key]['ecpm'] = float(exp_all_dic[key]['charge']*1000) / float(exp_all_dic[key]['impression'])
                    exp_all_dic[key]['pctr'] = float(exp_all_dic[key]['pclick']) / float(exp_all_dic[key]['impression'])
                    exp_all_dic[key]['show_acb'] = float(exp_all_dic[key]['show_acb1']) / float(exp_all_dic[key]['impression'])

                if exp_all_dic[key]['click'] > 0:
                    exp_all_dic[key]['acp'] = float(exp_all_dic[key]['charge']) / float(exp_all_dic[key]['click'])
                    exp_all_dic[key]['click_acb'] = float(exp_all_dic[key]['click_acb1']) / float(exp_all_dic[key]['click'])
                if exp_all_dic[key]['click_acb1'] > 0:
                    exp_all_dic[key]['click_price_bid'] = float(exp_all_dic[key]['charge']) / float(exp_all_dic[key]['click_acb1'])

    # diff cpc
    exp_v = exp_cpc_dic[exp]
    exp_dz_v = exp_cpc_dic[exp_dz]
    pv_diff = calc_diff(exp_v['impression'], exp_dz_v['impression'])
    clk_diff = calc_diff(exp_v['click'], exp_dz_v['click'])
    pctr_diff = calc_diff(exp_v['pctr'], exp_dz_v['pctr'])
    ctr_diff = calc_diff(exp_v['ctr'], exp_dz_v['ctr'])
    ecpm_diff = calc_diff(exp_v['ecpm'], exp_dz_v['ecpm'])
    charge_diff = calc_diff(exp_v['charge'], exp_dz_v['charge'])
    acp_diff = calc_diff(exp_v['acp'], exp_dz_v['acp'])
    show_acb_diff = calc_diff(exp_v['show_acb'], exp_dz_v['show_acb'])
    click_acb_diff = calc_diff(exp_v['click_acb'], exp_dz_v['click_acb'])
    click_price_bid_diff = calc_diff(exp_v['click_price_bid'], exp_dz_v['click_price_bid'])
    result_data_file.write(start_dt + "\t" + "CPC" + "\t" + 'diff' + "\t" + pv_diff + "\t" + clk_diff + "\t" + charge_diff + "\t" + ctr_diff + "\t" + pctr_diff + "\t" + acp_diff + "\t" + ecpm_diff + "\t" + show_acb_diff + "\t" + click_acb_diff + "\t" + click_price_bid_diff + "\n")
    result_data_file.write(start_dt + "\t" + "CPC" + "\t" + exp + "\t" + str(exp_v['impression']) + "\t" + str(exp_v['click'] )+ "\t" + str(int(exp_v['charge'])) + "\t" + format_str(exp_v['ctr'], 4) + "\t" + format_str(exp_v['pctr'], 4) + "\t" + format_str(exp_v['acp'], 3) + "\t" + format_str(exp_v['ecpm'], 3) + "\t" + format_str(exp_v['show_acb'], 3) + "\t" + format_str(exp_v['click_acb'], 3) + "\t" + format_str(exp_v['click_price_bid'], 3) + "\n")
    result_data_file.write(start_dt + "\t" + "CPC" + "\t" + exp_dz + "\t" +str(exp_dz_v['impression']) + "\t" + str(exp_dz_v['click'] )+ "\t" + str(int(exp_dz_v['charge'])) + "\t" + format_str(exp_dz_v['ctr'], 4) + "\t" + format_str(exp_dz_v['pctr'], 4) + "\t" + format_str(exp_dz_v['acp'], 3) + "\t" + format_str(exp_dz_v['ecpm'], 3) + "\t" + format_str(exp_dz_v['show_acb'], 3) + "\t" + format_str(exp_dz_v['click_acb'], 3) + "\t" + format_str(exp_dz_v['click_price_bid'], 3) + "\n")

    # diff all
    exp_v = exp_all_dic[exp]
    exp_dz_v = exp_all_dic[exp_dz]
    pv_diff = calc_diff(exp_v['impression'], exp_dz_v['impression'])
    clk_diff = calc_diff(exp_v['click'], exp_dz_v['click'])
    pctr_diff = calc_diff(exp_v['pctr'], exp_dz_v['pctr'])
    ctr_diff = calc_diff(exp_v['ctr'], exp_dz_v['ctr'])
    ecpm_diff = calc_diff(exp_v['ecpm'], exp_dz_v['ecpm'])
    charge_diff = calc_diff(exp_v['charge'], exp_dz_v['charge'])
    acp_diff = calc_diff(exp_v['acp'], exp_dz_v['acp'])
    show_acb_diff = calc_diff(exp_v['show_acb'], exp_dz_v['show_acb'])
    click_acb_diff = calc_diff(exp_v['click_acb'], exp_dz_v['click_acb'])
    click_price_bid_diff = calc_diff(exp_v['click_price_bid'], exp_dz_v['click_price_bid'])
    result_data_file.write(start_dt + "\t" + "all" + "\t" + 'diff' + "\t" + pv_diff + "\t" + clk_diff + "\t" + charge_diff + "\t" + ctr_diff + "\t" + pctr_diff + "\t" + acp_diff + "\t" + ecpm_diff + "\t" + show_acb_diff + "\t" + click_acb_diff + "\t" + click_price_bid_diff + "\n")
    result_data_file.write(start_dt + "\t" + "all" + "\t" + exp + "\t" + str(exp_v['impression']) + "\t" + str(exp_v['click'] )+ "\t" + str(int(exp_v['charge'])) + "\t" + format_str(exp_v['ctr'], 4) + "\t" + format_str(exp_v['pctr'], 4) + "\t" + format_str(exp_v['acp'], 3) + "\t" + format_str(exp_v['ecpm'], 3) + "\t" + format_str(exp_v['show_acb'], 3) + "\t" + format_str(exp_v['click_acb'], 3) + "\t" + format_str(exp_v['click_price_bid'], 3) + "\n")
    result_data_file.write(start_dt + "\t" + "all" + "\t" + exp_dz + "\t" +str(exp_dz_v['impression']) + "\t" + str(exp_dz_v['click'] )+ "\t" + str(int(exp_dz_v['charge'])) + "\t" + format_str(exp_dz_v['ctr'], 4) + "\t" + format_str(exp_dz_v['pctr'], 4) + "\t" + format_str(exp_dz_v['acp'], 3) + "\t" + format_str(exp_dz_v['ecpm'], 3) + "\t" + format_str(exp_dz_v['show_acb'], 3) + "\t" + format_str(exp_dz_v['click_acb'], 3) + "\t" + format_str(exp_dz_v['click_price_bid'], 3) + "\n")

    result_data_file.close()

if __name__ == '__main__':
    if len(sys.argv) > 2:
        start_date = str(sys.argv[1])
        end_date = str(sys.argv[2])
    elif len(sys.argv) > 1:
        start_date = str(sys.argv[1])
        dt = datetime.strptime(start_date, "%Y-%m-%d")
        days_num = calendar.monthrange(dt.year, dt.month)[1]
        end_date = (dt + timedelta(days=days_num)).strftime("%Y-%m-%d")
    else:
        start_date = (date.today() - timedelta(days=1)).strftime('%Y-%m-%d')
        dt = datetime.strptime(date.today(), "%Y-%m-%d")
        days_num = calendar.monthrange(dt.year, dt.month)[1]
        end_date = (dt + timedelta(days=days_num)).strftime("%Y-%m-%d")

    if start_date >= end_date:
        print "date error"
        sys.exit(0)
    conf = ConfigParser.ConfigParser()
    conf_file = 'conf/strategy_daily_conf.ini'
    conf.read(conf_file)
    now_hour = datetime.now().hour
    pad_zero = lambda x: (2 - len(str(x))) * '0' + str(x)
    today = date.today().strftime('%Y-%m-%d')

    sections = conf.sections()
    global_mail = [x.strip() for x in conf.get('global', 'mail').strip().split(',')]
    sections = sections[2:]
    if len(sections) == 0:
        print('no section on %s %s'% (today, now_hour))

    # article_location_comb
    article_location_comb_dic = get_article_comb()

    mail_start_date = start_date

    for section in sections:
        if section == 'example':
            continue

        options_dict = dict(conf.items(section))
        exp = options_dict.get('exp', '')
        exp_dz = options_dict.get('exp_dz','')
        mail = options_dict.get('mail', '')

        if exp == '':
            print('no exp on %s %s' % (today, now_hour))
            continue

        if exp_dz == '':
            exp_dz = exp + '_dz'

        mail_list = [x.strip() for x in mail.strip().split(',')]
        mail_list = global_mail + mail_list


        # output dic
        query_all_dic = {}
        query_cpc_dic = {}

        i = 0
        while start_date != end_date:
            for key, value in article_location_comb_dic.items():
                for v in value:
                    i += 1
                    site = v['site']
                    category = v['category']
                    location = v['location']
                    # exp
                    # all
                    query_list = get_filter(start_date, exp, site, category, location)
                    if len(query_list) > 0:
                        if exp not in query_all_dic:
                            query_all_dic[exp] = query_list
                        else:
                            query_all_dic[exp].extend(query_list)
                    # cpc
                    query_list = get_filter(start_date, exp, site, category, location, 'cpc')
                    if len(query_list) > 0:
                        if exp not in query_cpc_dic:
                            query_cpc_dic[exp] = query_list
                        else:
                            query_cpc_dic[exp].extend(query_list)
                    # exp_dz
                    # all
                    query_list = get_filter(start_date, exp_dz, site, category, location)
                    if len(query_list) > 0:
                        if exp_dz not in query_all_dic:
                            query_all_dic[exp_dz] = query_list
                        else:
                            query_all_dic[exp_dz].extend(query_list)
                    # cpc
                    query_list = get_filter(start_date, exp_dz, site, category, location, 'cpc')
                    if len(query_list) > 0:
                        if exp_dz not in query_cpc_dic:
                            query_cpc_dic[exp_dz] = query_list
                        else:
                            query_cpc_dic[exp_dz].extend(query_list)
            print("finish query date:%s" % start_date)
            tmp_date = (datetime.strptime(start_date, "%Y-%m-%d") + timedelta(days=1)).strftime("%Y-%m-%d")
            start_date = tmp_date
        #print query_cpc_dic
        #print query_all_dic
        # deal data
        result_file = 'data/result.' + str(start_date)
        if exp not in query_cpc_dic:
            print('strategy:' + exp + ' has no cpc data')
            continue
        if exp not in query_all_dic:
            print('strategy:' + exp + ' has no all data')
            continue
        if exp_dz not in query_cpc_dic:
            print('strategy:' + exp_dz + ' has no cpc data')
            continue
        if exp_dz not in query_all_dic:
            print('strategy:' + exp_dz + ' has no all data')
            continue

        mail_end_date = (datetime.strptime(end_date, "%Y-%m-%d") - timedelta(days=1)).strftime("%Y-%m-%d")
        dt = mail_start_date + " to " + mail_end_date
        deal_data(dt, query_cpc_dic, query_all_dic, result_file, exp, exp_dz)

        # send mail
        send_mail_bash = 'python send_mail_days.py %s %s %s %s %s %s' % (mail_start_date, mail_end_date, result_file, ','.join([x for x in mail_list if x != '']), exp, exp_dz)
        os.system(send_mail_bash)

    # clean data
    clean_data_bash = 'bash clean_data.sh %s' % (today)
    os.system(clean_data_bash)
