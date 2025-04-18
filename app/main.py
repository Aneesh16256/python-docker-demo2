from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello Aneesh"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)