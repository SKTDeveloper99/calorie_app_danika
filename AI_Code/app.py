import flask
import flask_cors

app = flask.Flask(__name__)
flask_cors.CORS(app)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/process_image', methods=['POST'])
def process_image():
    return 'Image processed!'

@app.route('/get_privacy_policy', methods=['GET'])
def get_privacy_policy():
    return 'Privacy policy'

if __name__ == '__main__':
    app.run()