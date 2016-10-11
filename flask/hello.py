from flask import Flask, render_template, jsonify, url_for
from pydruid.client import PyDruid
from pydruid.utils import aggregators, filters

query = PyDruid(
    'http://ec2-54-71-20-46.us-west-2.compute.amazonaws.com:8082', 'druid/v2')


def computeQuery(myfilter=None):

    if myfilter and 'badstr' in myfilter:

        filterList = myfilter.split('badstr')[:-1]

        if len(filterList) == 1:
            queryFilter = filters.Dimension('hashtags') == filterList[0]
        else:
            queryFilter = filters.Filter(
                type='and',
                fields=[filters.Dimension('hashtags') == item
                        for item in filterList]
            )
        top = query.topn(
            datasource='tweets-kafka',
            intervals='2015-06-27/2018-06-28',
            granularity='all',
            dimension='hashtags',
            metric='count',
            threshold=5+len(filterList),
            aggregations={'count': aggregators.count('count')},
            filter=queryFilter
            # filter=filters.Dimension('hashtags') == filterList[0]
        )
        return top[0]['result'][len(filterList):]
    else:
        top = query.topn(
            datasource='tweets-kafka',
            intervals='2016-10-08/2018-06-28',
            granularity='all',
            dimension='hashtags',
            metric='count',
            threshold=8,
            aggregations={'count': aggregators.count('count')}
        )
        return top[0]['result']

app = Flask(__name__)


@app.route("/data/")
@app.route("/data/<myfilter>")
def data(myfilter=None):
    top = computeQuery(myfilter=myfilter)
    children = []
    for hashmap in top:
        children.append(
            {'name': hashmap['hashtags'],
             'children': [{'name': 'loading...'}]})
    my_data = {'name': 'top', 'children': children}
    return jsonify(my_data)


@app.route("/root/")
@app.route("/root/<rootFilter>")
def root(rootFilter=None):
    top = computeQuery(myfilter=rootFilter)
    children = []
    for hashmap in top:
        children.append(
            {'name': hashmap['hashtags'],
             'children': [{'name': 'loading...'}]})
    my_data = {'name': 'top', 'children': children}
    return jsonify(my_data)


@app.route('/')
def hello_world():
    return render_template('hello.html', rootFilter="")
