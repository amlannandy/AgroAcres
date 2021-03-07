from datetime import datetime

from server.app import db

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
