from flask import Blueprint, jsonify

from server.app import scheduler
from server.models.Crop import Crop
from server.models.Record import Record
from server.scrapper import extract_crops_data

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
    except Exception as err:
        print(err)
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

@index.route('/extract')
def extract_crops():
    try:
        extract_crops_data()
        response = {
            'success': True,
            'msg': 'Data extracted',
        }
        return jsonify(response), 200
    except Exception as err:
        print(err)
        response = {
            'success': False,
            'msg': 'Something went wrong!',
        }
        return jsonify(response), 500

@scheduler.task('interval', id='do_job_1', seconds=86400, misfire_grace_time=900)
def extract_crops_automatically():
    try:
        extract_crops_data()
        print('Crops data extracted')
    except Exception as err:
        print(err)