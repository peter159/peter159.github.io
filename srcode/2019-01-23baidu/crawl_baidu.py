# -*- coding: utf-8 -*-

import requests
import pandas as pd

from bs4 import BeautifulSoup

keywords = ["特朗普", "克林顿", "习近平", "朱镕基",
            "戴森吹风机", "外卖小哥11家公司", "甲骨文薪酬歧视", "包贝尔小品被毙",
            "中国著名大学", "北京人均收入", "上海人均收入", "深圳人均收入",
            "牲畜", "妓女", "奴隶", "米格战斗机"]


def get_baidu(keyword):
    headers = {'content-type': 'application/json',
               'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1'}

    url = "https://www.baidu.com/s?wd={}"
    request = requests.get(url.format(keyword), timeout=3, headers=headers)
    bsre = BeautifulSoup(request.content, "lxml")
    lsts = bsre.select('#content_left div h3 a')
    hrefs = [href.get("href") for href in lsts]
    hrefs_ref = []
    for href in hrefs:
        try:
            hrefs_ref += [requests.get(href).url]
        except Exception as e:
            hrefs_ref += [href]
            # print("parsing error: {}".format(href))
    return [hrefs_ref, keyword]


def parse_hrefs(hrefs, keyword):
    length = len(hrefs)
    bd_exists = sum(['baidu' in href for href in hrefs if href])
    return [bd_exists / length, length, keyword]


if __name__ == "__main__":
    # hrefs, keyword = get_baidu("妓女")
    # print(hrefs)
    # print(parse_hrefs(hrefs, keyword))
    df = pd.read_excel("e:/github/peter159.github.io/srcode/2019-01-23baidu/query-hive-7561.xlsx")
    # keywords = keywords + df['attr_5'].dropna()[:30]

    all_result = []
    for keyword in keywords:
        print("now retrieving for keyword {}".format(keyword))
        hrefs, kw = get_baidu(keyword)
        all_result += [parse_hrefs(hrefs, kw)]
    print(all_result)
    df = pd.DataFrame(all_result, columns=['ratio', 'all', 'keyword'])
    df.to_csv("./keyword_ratio.csv", index=False)
    print("=" * 120)
    print("writed also to local disk")
