from flask import Blueprint, jsonify
from server.models.Crop import Crop

index = Blueprint('routes', __name__)

@index.route('/')
def get_crop_prices():
    crops = Crop.query.all()
    response = {
        'success': True,
        'data': list(map(lambda c: c.to_json(), crops)),
    }
    return jsonify(response), 200
