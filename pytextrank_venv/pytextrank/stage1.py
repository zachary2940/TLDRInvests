#!/usr/bin/env python
# encoding: utf-8

from stock_news_crawler import getArticlesData
from pytextrank import json_iter, parse_doc, pretty_print
import sys
import stage2, stage3, stage4
import json
import os
import time


## Stage 1:
##  * perform statistical parsing/tagging on a document in JSON format
##
## INPUTS: <stage0>
## OUTPUT: JSON format `ParsedGraf(id, sha1, graf)`

if __name__ == "__main__":
    stock_name = sys.argv[1]
    count = 0
    start = time.time()
    for JSONArticle in getArticlesData(stock_name):
        count+=1
        print("=============== Article {} ================".format(count))
        with open('intermediate_output/o1.json', 'w+') as f:
            for graf in parse_doc(JSONArticle): 
                graf = pretty_print(graf._asdict())
                # print(graf)
                f.write(graf.strip() + '\n')
        os.system("python stage2.py intermediate_output/o1.json > intermediate_output/o2.json")
        os.system("python stage3.py intermediate_output/o1.json intermediate_output/o2.json > intermediate_output/o3.json")
        os.system("python stage4.py intermediate_output/o2.json intermediate_output/o3.json > summary_output/o4_Article_{}.md".format(count))
    end = time.time()
    print ("time is {}".format(end-start))



