from flask import Blueprint, jsonify

routes = Blueprint('routes', __name__)

@routes.route('/')
def get_crop_prices():
  response = {
    'success': True,
    'msg': 'Get prices route',
  }
  return jsonify(response), 200