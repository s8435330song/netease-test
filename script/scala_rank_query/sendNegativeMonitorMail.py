#-*- coding:utf-8 -*-

import sys
import os

def readCsv(file):
    data = []
    with open(file, 'r') as f:
        for line in f:
            line = line.replace('\n','').strip().split(',')
            data.append(line)
    return data

def add_table_in_html(table_list, content = ""):
    table_html = content
    table_html += "<table width='100%' class='table'>"
    ct = 0
    for line in table_list:
        if ct == 0:
            table_html += "<tr><th>" + "</th><th>".join([str(x) for x in line]) + "</th></tr>"
        else:
            if ct % 2 == 0:
                table_html += "<tr class='alter'><td>" + "</td><td>".join([str(x) for x in line]) + "</td></tr>"
            else:
                table_html += "<tr><td>" + "</td><td>".join([str(x) for x in line]) + "</td></tr>"
        ct += 1
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
    if len(argv) < 2:
        print("mail need parameters!")
        sys.exit(0)
    else:
        file1_name = argv[1]
        data = readCsv(file1_name)

        content = add_table_in_html(data, "<h1>负反馈监控，nfl_exp：开启负反馈功能，nfl_exp_dz：未开启负反馈功能，no_tag：没有具体标签</h1><br/><h1>分操作系统具体看附件 os => 1:Android, 2:ios, 3:win, 4:mac os, 5:unix, 0:其他</h1><br/>") + "<br/>"
        content = html_wrap(content)

        print (content)


if __name__=='__main__':
    send_monitor_data(sys.argv)