import os
from flask import Flask
from dotenv import load_dotenv
from flask_sqlalchemy import SQLAlchemy
from flask_apscheduler import APScheduler

# Init db
db = SQLAlchemy()

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Setup config
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['SCHEDULER_API_ENABLED'] = True

# Init scheduler
scheduler = APScheduler()
scheduler.init_app(app)
scheduler.start()

# Init db
db.init_app(app)

# Import routes
from server.routes.index import index as IndexBlueprint

app.register_blueprint(IndexBlueprint)