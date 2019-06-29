# import libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import re
import json

# get all links at business times and return a list of top 5 URLs.
# name params if more than 1 word must represent space with %20 (E.g Singapore%20Airlines)
def getLinks(name):
    page = "https://www.businesstimes.com.sg/search/" + name + "%20stocks?page=1&filter=headline_en"
    # query the website and return the html to the variable page with header to pass off as browser
    req = Request(page, headers={'User-Agent': 'Mozilla/5.0'})
    webpage = urlopen(req).read()
    # parse the html using beautiful soup and store in variable `soup`
    soup = BeautifulSoup(webpage, "html.parser")
    index = 0
    listOfLinks = []
    for link in soup.find_all('a', attrs={'href': re.compile("^https://")}):
        if index > 0 and index < 6:
            listOfLinks.append(link.get('href'))
        index += 1
    return listOfLinks
    
# get all article data in a JSON and return a list of JSON for the top 5 URLs articles from getLinks()
def getArticlesData(name):
    links = getLinks(name)
    listOfJSONArticles = []
    for x in range(len(links)):
        link = links[x]
        # print(link)
        req = Request(link, headers={'User-Agent': 'Mozilla/5.0'})
        webpage = urlopen(req).read()
        soup = BeautifulSoup(webpage, "html.parser")
        headline = soup.find("h1", {"class":"headline"}).text
        article_text = ''
        article = soup.find("div", {"class":"field field-name-body field-type-text-with-summary field-label-hidden"}).findAll('p')
        for element in article:
            article_text += '\n' + ''.join(element.findAll(text = True))
        articleDict = {
            "id": x + 1,
            "headline": headline,
            "text": article_text
        }
        listOfJSONArticles.append(articleDict)
    return listOfJSONArticles
    # yield articleDict

# getArticlesData("DBS")