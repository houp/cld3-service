#!/usr/bin/python3
from flask import Flask
from flask import request
from flask import jsonify
app = Flask(__name__)
import cld3

@app.route('/detect', methods=['POST'])
def detect():
    content = request.get_json()
    sentence = content['sentence']
    prediction = cld3.get_language(sentence)
    return jsonify({"lang":prediction.language, "probability":prediction.probability, "is_reliable":prediction.is_reliable})

if __name__ == '__main__':
    app.run()