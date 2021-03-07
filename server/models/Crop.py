from datetime import datetime

from server.app import db

class Crop(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)
    price = db.Column(db.Float, nullable=False)
    last_updated = db.Column(
        db.DateTime, nullable=False, default=datetime.utcnow)

    def __init__(self, name, price):
        self.name = name
        self.price = price

    def to_json(self):
        return {
            'id': self.id,
            'name': self.name,
            'price': self.price,
            'last_updated': self.last_updated,
        }
