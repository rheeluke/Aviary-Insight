from flask import Flask, render_template, jsonify, url_for
from pydruid.client import PyDruid
from pydruid.utils import aggregators

query = PyDruid(
    'http://ec2-54-71-20-46.us-west-2.compute.amazonaws.com:8082', 'druid/v2')


def computeQuery(filter=None):

    if filter:
        top = query.topn(
            datasource='tweets-kafka',
            intervals='2015-06-27/2018-06-28',
            granularity='all',
            dimension='hashtags',
            metric='count',
            threshold=4,
            aggregations={'count': aggregators.count('count')},
            filter=Dimension('hashtags') == filter
        )
        return top[0]['result']

    else:
        top = query.topn(
            datasource='tweets-kafka',
            intervals='2015-06-27/2018-06-28',
            granularity='all',
            dimension='hashtags',
            metric='count',
            threshold=4,
            aggregations={'count': aggregators.count('count')},
        )
        return top[0]['result']

app = Flask(__name__)


@app.route("/data/")
@app.route("/data/<filter>")
def data():
    top = computeQuery(filter)
    children = []
    for hashmap in top:
        children.append({'name': hashmap['hashtags']})
    my_data = {'name': 'top', 'children': children}
    return jsonify(my_data)


@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)


@app.route('/')
def hello_world():
    # return 'hi'
    # top = computeQuery()
    # out = json.jsonify(name='top',
    #               children=list(map(lambda x: json.jsonify(name=x['hashtags']), top[0]['result'])))
    return render_template('hello.html', out='static/flare.json')
    # return str(computeQuery())


@app.route('/out')
def returnout():
    # return 'hi'
    return 'static/flare.json'


# @app.route('/hello')
# def hello():
#     return 'Hello, World'


@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'User %s' % username


@app.route('/post/<int:post_id>')
def show_post(post_id):
    # show the post with the given id, the id is an integer
    return 'Post %d' % post_id

from flask import request


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        do_the_login()
    else:
        show_the_login_form()
