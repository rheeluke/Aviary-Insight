package rheeluke.streams;

import rheeluke.streams.avro.Tweet;
import rheeluke.streams.utils.SpecificAvroSerde;

import io.confluent.kafka.serializers.AbstractKafkaAvroSerDeConfig;
import org.apache.kafka.clients.consumer.ConsumerConfig;

import org.apache.kafka.common.serialization.Serde;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KStreamBuilder;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.processor.WallclockTimestampExtractor;

import java.util.Properties;

@SuppressWarnings("unchecked")
public class TwitterProcessor {

    private KafkaStreams kafkaStreams;

    public static void main(String[] args) throws  IOException {
        TwitterProcessor streamsProcessor = new TwitterProcessor();
        streamsProcessor.run();
    }

    public void run()  {

        final StreamsConfig streamsConfig = new StreamsConfig(getProperties());

        final KStreamBuilder kStreamBuilder = new KStreamBuilder();

        final KStream<String, Tweet> tweetKStream = kStreamBuilder.stream("twitter");

        final KStream<String, Tweet> relevantStream = tweetKStream
            .filter((dummy, tweet) -> new Boolean(tweet.get("entites").get("hashtags").size() > 1))
            .mapValues((tweet) -> tweet.get("entities").get("hashtags").stream().map((hashtag) -> hashtag.get("text")).toArray());

        relevantStream.to(Serdes.String().getClass().getName()), Serdes.String().getClass().getName()), "druid");

        kafkaStreams = new KafkaStreams(kStreamBuilder, streamsConfig);

        System.out.println("Starting twitter processor stream");
        kafkaStreams.start();
        System.out.println("Started");

    }

    public void stop() {
        kafkaStreams.close();
        System.out.println("KStreams stopped");
    }


    private static Properties getProperties() {
        Properties props = new Properties();
        props.put(StreamsConfig.CLIENT_ID_CONFIG, "Twitter-Streams-Analysis");
        props.put("group.id", "twitter-streams");
        props.put(StreamsConfig.APPLICATION_ID_CONFIG, "twitter-streams-id");
        props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        props.put(StreamsConfig.ZOOKEEPER_CONNECT_CONFIG, "localhost:2181");
        props.put(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, "localhost:8079");
        props.put(StreamsConfig.KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
        props.put(StreamsConfig.VALUE_SERDE_CLASS_CONFIG, SpecificAvroSerde.class);
        props.put(StreamsConfig.REPLICATION_FACTOR_CONFIG, 1);
        props.put(StreamsConfig.TIMESTAMP_EXTRACTOR_CLASS_CONFIG, WallclockTimestampExtractor.class);
        return props;
    }
}
