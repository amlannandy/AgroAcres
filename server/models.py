from datetime import datetime
from app import db


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


class Record(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    count = db.Column(db.Integer, nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)

    def __init__(self, count):
        self.count = count

    def to_json(self):
        return {
            'id': self.id,
            'count': self.count,
            'timestamp': self.timestamp,
        }
