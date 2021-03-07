import sys
sys.path.append('..')

from server.app import app, db
from server.models.Crop import Crop
from server.models.Record import Record

with app.app_context():
    db.create_all()
