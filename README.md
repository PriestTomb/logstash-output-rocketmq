# logstash-output-rocketmq

Logstash plugin output to Rocketmq

[中文说明](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/README_zh.md)

## Description

I am not skilled in Logstash, Rocketmq and Ruby (in addition, my english is not good too...), just because there are no official or third-party rocketmq output plugin found on the web. **This is just a demo written for work needs**, so the Rspec file is not written. Share the code for reference only, if you want to use it, please rewrite the core code.

Learned the source code of some Logstash output plugins: [logstash-output-kafka](https://github.com/logstash-plugins/logstash-output-kafka), [logstash-output-rabbitmq](https://github.com/logstash-plugins/logstash-output-rabbitmq), [logstash-output-jdbc](https://github.com/theangryangel/logstash-output-jdbc)

## Versions

This demo is based on Logstash v6.4 and Rocketmq Client v4.2, other versions are not clear.

update 2019-03-12 : Tested on the latest version of Logstash v6.6 can also be successfully installed and used.

## Change Log

#### [v0.1.4] 2019-03-12

* add and mod configurations, the `topic`,`tag`,`key`,`body` attributes of the Message object can be formatted, for an example of formatting, you can refer to [Logstash configuration file example and description](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/example/README.md) (sorry, this document is only available in Chinese)

#### [v0.1.3] 2019-02-23

* add codec plugin, method `multi_receive` is modified into method `multi_receive_encoded`, so that the rocketmq plugin can configure the codec plugin to formatting the received event.

* fixes a bug about `RangeError: too big for byte` error occurs when Ruby's byte array is converted to Java's byte array.(This bug is currently known when there is Chinese in the event.)

#### [v0.1.2] 2019-01-20

* fixes a bug about Ruby instance variable.

#### [v0.1.1] 2019-01-19

* adds a configuration option `key`.

* adds `concurrency :shared` configuration for plugin, otherwise, the event cannot be processed concurrently.

* fixes a bug about event object cast to byte arrays occasionally caused the plugin to crash.

* fixes a bug about `retry_times`.

#### [v0.1.0] 2019-01-03

* just a demo that can run.

## Installation

* If the installation environment has internet (Refer to [Logstash output plugin test installation](https://www.elastic.co/guide/en/logstash/current/_how_to_write_a_logstash_output_plugin.html#_test_installation_4))

  * Place the jar file in rocketmq_jar in /vendor/jar/rocketmq in the installation directory of Logstash

  * Put logstash-output-rocketmq-0.1.0.gem in the installation directory of Logstash

  * Run `bin/logstash-plugin install logstash-output-rocketmq-0.1.0.gem` in the installation directory of Logstash

* If the installation environment dose not have internet (Refer to [Logstash installing offline plugin packs](https://www.elastic.co/guide/en/logstash/current/offline-plugins.html#installing-offline-packs))

  * Place the jar file in rocketmq_jar in /vendor/jar/rocketmq in the installation directory of Logstash

  * Put logstash-offline-plugins-6.4.0.zip in the installation directory of Logstash

  * Run `bin/logstash-plugin install file:///path/to/logstash-offline-plugins-6.4.0.zip` in the installation directory of Logstash

## Configurations

|Option|Type|Description|Required?|Default|
|---|---|---|---|---|
|logstash_path|String|The installation directory of Logstash, e.g. C:/ELK/logstash, /usr/local/logstash|Yes||
|name_server_addr|String|Rocketmq's NameServer address, e.g. 192.168.10.10:5678|Yes||
|producer_group|String|Rocketmq's producer group|No|defaultProducerGroup|
|topic|String|Message's topic|Yes||
|topic_format|boolean|is topic need to use formatting|No|false|
|tag|String|Message's tag|No|defaultTag|
|tag_format|boolean|is tag need to use formatting|No|false|
|key|String|Message's key|No|defaultKey|
|key_format|boolean|is key need to use formatting|No|false|
|body|String|Message's body|No||
|body_format|boolean|is body need to use formatting|No|false|
|retry_times|Number|Number of retries after failed delivery|No|2|
|codec|Object|codec plugin config|No|plain|

## Rewrite & Rebuild

The core file is [rocketmq.rb](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/lib/logstash/outputs/rocketmq.rb), if you have modified this file, you can run `gem build logstash-output-rocketmq.gemspec` to rebuild the gem file, or you can run `bin/logstash-plugin prepare-offline-pack logstash-output-rocketmq` to rebuild the offline packs (Refer to [Logstash building offline plugin packs](https://www.elastic.co/guide/en/logstash/current/offline-plugins.html#building-offline-packs))
