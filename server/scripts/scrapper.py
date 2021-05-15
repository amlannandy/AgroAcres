import requests
from bs4 import BeautifulSoup

URL = 'https://agriplus.in/prices/paddy-dhan-common/odisha'

page = requests.get(URL)
soup = BeautifulSoup(page.content, 'html.parser')
body = soup.find(name='tbody')
tags = body.findAll(name='tr')

for t in tags:
  info = t.findAll(name='td')
  for i in info:
    print(i.text)
  print('\n\n')

# def extract_articles():
#   articles = []
#   for a in articleTags:
#     titleTag = a.find('h1', class_='entry-title')
#     title = titleTag.text
#     url = titleTag.find('a')['href']
#     content = a.find('p').text.split('… Continue reading')[0]
#     article = {
#       'title': title,
#       'content': content,
#       'url': url,
#     }
#     articles.append(article)
#   return articles