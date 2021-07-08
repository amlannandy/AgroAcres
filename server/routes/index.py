from flask import Blueprint, jsonify
from server.models.Crop import Crop
from server.models.Record import Record

index = Blueprint('', __name__)

@index.route('/')
def get_crop_prices():
    try:
        crops = Crop.query.all()
        response = {
            'success': True,
            'data': list(map(lambda c: c.to_json(), crops)),
            'msg': 'Crops fetched successfully!',
        }
        return jsonify(response), 200
    except:
        response = {
            'success': False,
            'msg': 'Something went wrong!',
        }
        return jsonify(response), 500

@index.route('/records')
def get_all_records():
    try:
        records = Record.query.all()
        response = {
            'success': True,
            'data': list(map(lambda r: r.to_json(), records)),
            'msg': 'Records fetched successfully!',
        }
        return jsonify(response), 200
    except:
        response = {
            'success': False,
            'msg': 'Something went wrong!',
        }
        return jsonify(response), 500