from app import app

import datetime
from flask import Flask
from flask import jsonify
from flask import render_template
from flask import url_for
from pydruid.client import PyDruid
from pydruid.utils import aggregators
from pydruid.utils import filters


@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html')


@app.route("/data/")
@app.route("/data/<myfilter>")
def data(myfilter=None):
    top = computeQuery(myfilter)
    children = []
    for hashmap in top:
        children.append(
            {'name': hashmap['hashtags'], 'count': hashmap['count'],
             'children': [{'name': 'loading...'}]})
    my_data = {'name': 'top', 'children': children}
    return jsonify(my_data)

query = PyDruid(
    'http://ec2-54-71-20-46.us-west-2.compute.amazonaws.com:8082', 'druid/v2')


def computeQuery(myfilter):

    current_time = datetime.datetime.utcnow()
    previous_time = current_time - datetime.timedelta(1)
    interval = previous_time.isoformat() + '/' + current_time.isoformat()

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
            datasource='twitter',
            intervals=interval,
            granularity='all',
            dimension='hashtags',
            metric='count',
            threshold=5+len(filterList),
            aggregations={'count': aggregators.count('count')},
            filter=queryFilter
        )

        return top[0]['result'][len(filterList):]

    else:
        top = query.topn(
            datasource='twitter',
            intervals=interval,
            granularity='all',
            dimension='hashtags',
            metric='count',
            threshold=8,
            aggregations={'count': aggregators.count('count')}
        )
        return top[0]['result']
