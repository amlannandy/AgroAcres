import os
import requests
from dotenv import load_dotenv
from bs4 import BeautifulSoup

from server.app import db
from server.models.Crop import Crop

load_dotenv()

URL = os.getenv('MANDI_URL')

page = requests.get(URL)
soup = BeautifulSoup(page.content, 'html.parser')
body = soup.find(name='body')
tags = body.find_all('div', {'class': 'mob_p_12'})

def extract_crops_data():
  try:
    Crop.query.delete()
    for t in tags:
      # Get crop name directly
      crop_name = t.find_next('div', {'class': 'mob_p_02'}).text.split(':')[0].strip()

      # Location, quantity and modal price
      crop_deails = t.find_all_next('div', {'class': 'mob_p_06'})
      location = str(crop_deails[0].text).split(':')[1].strip()
      quantity = str(crop_deails[1].text).split(':')[1].strip()
      modal_price = str(crop_deails[2].text).split(':')[1].strip()

      # Min and max price
      min_max_price = t.find_next('div', { 'class': 'mob_p_09'}).text
      min_price = min_max_price.split('/')[0][1:].strip()
      max_price = min_max_price.split('/')[1].strip()

      crop = Crop(
        name=crop_name,
        location=location,
        quantity=quantity,
        modal_price=modal_price,
        min_price=min_price,
        max_price=max_price,
      )
      db.session.add(crop)
    db.session.commit()
  except Exception as err:
    print(err)