import os
from flask import Flask
from dotenv import load_dotenv
from flask_sqlalchemy import SQLAlchemy

# Init db
db = SQLAlchemy()

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Import routes
from server.routes.index import index as IndexBlueprint

app.register_blueprint(IndexBlueprint)

# Setup and integrate db
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db.init_app(app)
