package rheeluke.streams

import java.util.Properties

import org.apache.kafka.common.serialization._
import org.apache.kafka.streams._
import org.apache.kafka.streams.kstream.{KStream, KStreamBuilder}

object TwitterStream {

  def main(args: Array[String]) {
    val builder: KStreamBuilder = new KStreamBuilder

    val streamingConfig = {
      val settings = new Properties
      settings.put(StreamsConfig.APPLICATION_ID_CONFIG, "twitter-stream")
      settings.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092")
      settings.put(StreamsConfig.ZOOKEEPER_CONNECT_CONFIG, "localhost:2181")
      settings.put(StreamsConfig.KEY_SERDE_CLASS_CONFIG, Serdes.String.getClass.getName)
      settings.put(StreamsConfig.VALUE_SERDE_CLASS_CONFIG, Serdes.String.getClass.getName)
      settings
    }

    def toInt(s: String): Int = {
      try {
        s.toInt
      } catch {
        case e: Exception => -1
      }
    }

    val tweetStream: KStream[String, String] = builder.stream("connect-twitter")

    import KeyValueImplicits._

    val filteredStream: KStream[String, String] = tweetStream
        .filter((numHashtags, jsonString) => toInt(numHashtags) > 1)

    filteredStream.to("stream-twitter")

    val stream: KafkaStreams = new KafkaStreams(builder, streamingConfig)
    stream.start()
  }

}
