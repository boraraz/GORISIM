from flask import Flask, request, jsonify


app = Flask(__name__)

@app.route('/api', methods = ['GET'])
def returnascii():
    d = {}
    inputchr = str(request.args['query'])
    answer = str(ord(inputchr))
    d['output'] = answer
    return d



@app.route('/PythonProject', methods = ['GET'])
def returnUsername():
    try:
        username = request.args.get('username')
        print(f'Username received: {username}')
        

        return username
    except Exception as e:
        print(f'Error: {e}')
        return 'Failed to receive username.'

@app.route('/PythonProject', methods = ['POST'])
def process_post_request():
    data = request.form
    key1 = data.get('key1')
    key2 = data.get('key2')
    return 'Data received and processed successfully!'

if __name__ == '__main__':
    app.run(debug=True)