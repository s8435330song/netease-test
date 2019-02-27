#-*- coding:utf-8 -*-

import sys
import os
import json

def readCsv(file):
    data = {}
    with open(file, 'r') as f:
        for line in f:
            line = json.loads(line.strip())
            for key in line['_1'].split(','):
                if data.has_key(key):
                    data[key] += int(line['_2'])
                else:
                    data[key] = int(line['_2'])
    #print data
    return data

def readlog(file):
    f=open(file,'r')
    for line in f:
        if('All query count:' in line ):
            line.split(':')
            ret = [line.split('\t')[0].split(':')[1],line.split('\t')[3].split(':')[1]]
            break
    return ret


def mergedict(dict1,dict2):
    finaldict = {}
    #dict1为有广告的策略，dict2为没有广告的策略
    for key in set(dict1.keys()+dict2.keys()):
        if dict1.has_key(key) and dict2.has_key(key):
            finaldict[key] = [dict1[key],dict2[key],round(float(dict2[key])*10000/dict1[key],5)]
        elif dict1.has_key(key) and not dict2.has_key(key):
            finaldict[key] = [dict1[key],0,0]
        else:
            finaldict[key] = [0,dict2[key],"null"]
    #print finaldict
    return finaldict


def add_table_in_html(table_dict,all_list, content = ""):
    table_html = content
    table_html += "<table width='100%' class='table' border='1'>"
    table_html += "<tr><th>" + "策略" + "</th><th>" + "有广告" + "</th><th>" + "无广告" + "</th><th>" + "无广告占比（万分之）" + "</th>"
    table_html += "<tr><th>" + "总数" + "</th><th>" + all_list[0] + "</th><th>" + all_list[1] + "</th><th>" + str(round(float(all_list[1])*10000/int(all_list[0]),5)) + "</th>"
    for key in sorted(table_dict.items(),key=lambda x:x[1][1],reverse = True):
            table_html += "<tr><th>" + str(key[0]) + "</th><th>" + str(table_dict[key[0]][0])+ "</th><th>" + str(table_dict[key[0]][1])+ "</th><th>" + str(table_dict[key[0]][2])+ "</th>"
    table_html += "</table>"

    return table_html

def html_wrap(html_content):
    """
    如果发送的内容是html格式的，那么必须使用该函数对html内容进行包装，否则html格式会无法正常显示。
    """
    header = """
        <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style type="text/css">
        body, table{font-size:12px;}
        table{
            table-layout:fixed;
            empty-cells:show;
            border-collapse: collapse;
            margin:0 auto;
        }
        td{height:30px;}
        h1, h2, h3{
            font-size:12px;
            margin:0;
            padding:0;
        }
        .table{
            border:1px solid #cad9ea;
            color:#666;
        }
        .table th{
            background-repeat:repeat-x;
            height:30px;
        }
    .   table td, .table th{
            border:1px solid #cad9ea;
            padding:0 1em 0;
        }
        .table tr.alter{
            background-color:#f5fafe;
        }
        </style>
        </head>
        <body>
        """
    tail = """
        </body>
        </html>
        """
    return header + html_content + tail

def send_monitor_data(argv):
    if len(argv)<3:
        print("mail need parameters!")
        sys.exit(0)
    else:
        file1 = argv[1]
        file2 = argv[2]
        file3 = argv[3]
        resultData1 = readCsv(file1)
        resultData2 = readCsv(file2)
        resultData3 = readlog(file3)
        fdict = mergedict(resultData1,resultData2)
        content = add_table_in_html(fdict,resultData3)
       
        #content = add_table_in_html(finalData, "<h1>"+ expConf +"</h1><br/>") + "<br/>"
        content = html_wrap(content)

        print (content)


if __name__=='__main__':
    send_monitor_data(sys.argv)