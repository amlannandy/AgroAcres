from app import app, db
from models import Crop, Record

with app.app_context():
    db.create_all()
