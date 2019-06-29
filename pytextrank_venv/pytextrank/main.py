#!/usr/bin/env python
# encoding: utf-8

from stock_news_crawler import getArticlesData
from pytextrank import json_iter, parse_doc, pretty_print
import sys
import stage1, stage2, stage3, stage4
import json
import os

if __name__ == "__main__":
    # path_stage0 = sys.argv[1]

    # for graf in parse_doc(json_iter(path_stage0)):
    #     print(pretty_print(graf._asdict()))
    os.system("python stage1.py DBS > o1_test.json")


        # stage2.stagetwo("o1.json")