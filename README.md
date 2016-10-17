# [Hashtag-Hashtag](http://htht.tech)

## Table of contents
1. [Introduction](README.md#introduction)
2. [AWS Clusters](README.md#aws-clusters)
3. [Data Pipeline](README.md#data-pipeline)
4. [Performance](README.md#performance)
5. [Presentation](README.md#presentation)


## Introduction
[Back to Table of contents](README.md#table-of-contents)

[Hashtag-Hashtag](http://htht.tech) is a Twitter analytics platform designed to explore the realtime relationships between Twitter hashtags. As a big data pipeline it makes use of current open source technologies atop of AWS clusters to ingest, process and display streaming data from twitter.

On load, the application returns a tree graph whose leaves represent to the most frequently occurring hashtags over the last 24 hours. On node click, the application will query the database and append to the node the most frequently occurring hashtags that have appeared in a tweet with the hashtag-nodes in its path. This process is repeatable.

![Alt text](flask/app/static/img/htht_graph.png?raw=true "Hashtag-Hashtag Tree")


## AWS Clusters
[Back to Table of contents](README.md#table-of-contents)

[Hashtag-Hashtag](http://htht.tech) runs on three clusters on 8 AWS instances:
<ul>
<li>5 m4.xlarge nodes for Zookeeper and Kafka</li>
<li>3 m4.xlarge nodes for Druid </li>
<li>1 m4.xlarge node for Flask and Tornado</li>
</ul>
One node is shared between the Zookeeper/Kafka and Druid clusters. This node contains the Druid Master.
A separate node in the Zookeeper/Kafka cluster houses the processes for Kafka Connect and Kafka Streams.

## Data Pipeline
[Back to Table of contents](README.md#table-of-contents)

The image below depicts the underlying data pipeline.

![Alt text](flask/app/static/img/pipeline.png?raw=true "Pipeline")

The image below depicts the underlying Druid cluster.

![Alt text](flask/app/static/img/druid_cluster.png?raw=true "Druid Cluster")

### Data source / Kafka Connect
The data stream's source is the English Sample of the Twitter Streaming API. This data is ingested via Kafka through Kafka Connect using a modified version of [Kafka Connect Twitter](https://github.com/Eneco/kafka-connect-twitter). The connector prepares the tweet for filtering via Kafka Streams and reformats the time signature of the data.

The Kafka Connector is written in Scala.

### Kafka Streams
Kafka Streams filters the incoming data for the tweets with multiple hashtags.

The Kafka Stream is written in Scala.

### Data bases
The resulting values are stored in Druid via the built in extension, druid-kafka-indexing-service. The resulting table has three columns: created_at, hashtags, count

Hashtags from a tweet are stored together as a list of strings under the hashtag column. This prepares the table for a TopN query to extract for the most frequently occurring hashtags that have appeared in tweet with the hashtag(s) of your choosing.

### Pegasus
[Pegasus](https://github.com/InsightDataScience/pegasus) is used to quickly deploy and manage a number of distributed technologies atop AWS.

## Performance
[Back to Table of contents](README.md#table-of-contents)

The current system uses queries over the last 24 hours. Incoming Twitter data comes in at a rate of approximately 1k to 2k tweets per min and resents 1% of the Twitter Firehose. At last check, the query was processing over 92.6k rows.

## Presentation
[Presentation](https://goo.gl/26PQ1X) and demo [video](https://youtu.be/s7U2mIi4SOE) for Hashtag-Hashtag.
