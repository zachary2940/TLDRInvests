# import libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import re

# specify the url
page = "https://flutterawesome.com/a-flutter-musical-app-built-with-nodejs-and-firebase/"

# query the website and return the html to the variable ‘page’
req = Request(page, headers={'User-Agent': 'Mozilla/5.0'})
webpage = urlopen(req).read()

# parse the html using beautiful soup and store in variable `soup`
soup = BeautifulSoup(webpage, "html.parser")

with open('test.txt', 'w') as f:
    for tag in soup.find_all('p'):
        f.write(tag.text + '\n')
# links = [a.get('href') for a in soup.find_all('a', href=True)]

# print(*links, sep = "\n") 