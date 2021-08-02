from datetime import datetime

from server.app import db

class Crop(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)
    location = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.String(20), nullable=False)
    modal_price = db.Column(db.String(20), nullable=False)
    min_price = db.Column(db.String(20), nullable=False)
    max_price = db.Column(db.String(20), nullable=False)
    last_updated = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)

    def __init__(self, name, location, quantity, modal_price, min_price, max_price):
        self.name = name
        self.location = location
        self.quantity = quantity
        self.modal_price = modal_price
        self.min_price = min_price
        self.max_price = max_price

    def to_json(self):
        return {
            'id': self.id,
            'name': self.name,
            'location': self.location,
            'quantity': self.quantity,
            'modal_price': self.modal_price,
            'min_price': self.min_price,
            'max_price': self.max_price,
            'last_updated': self.last_updated,
        }
