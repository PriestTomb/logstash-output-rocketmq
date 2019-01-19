# logstash-output-rocketmq

LogStash plugin output to Rocketmq

[中文说明](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/README_zh.md)

## Description

I am not skilled in LogStash, Rocketmq and Ruby (in addition, my english is not good too...), just because there are no official or third-party rocketmq output plugin found on the web. **This is just a demo written for work needs**, so the Rspec file is not written. Share the code for reference only, if you want to use it, please rewrite the core code.

Learned the source code of some LogStash output plugins: [logstash-output-kafka](https://github.com/logstash-plugins/logstash-output-kafka), [logstash-output-rabbitmq](https://github.com/logstash-plugins/logstash-output-rabbitmq), [logstash-output-jdbc](https://github.com/theangryangel/logstash-output-jdbc)

## Versions

This demo is based on LogStash v6.4 and Rocketmq Client v4.2, other versions are not clear.

## Change Log

#### [v0.1.1] 2019-01-19

* adds a configuration option `key`.

* adds `concurrency :shared` configuration for plugin, otherwise, the event cannot be processed concurrently.

* fixes a bug about event object cast to byte arrays occasionally caused the plugin to crash.

* fixes a bug about `retry_times`.

#### [v0.1.0] 2019-01-03

* just a demo that can run.

## Installation

* If the installation environment has internet (Refer to [LogStash output plugin test installation](https://www.elastic.co/guide/en/logstash/current/_how_to_write_a_logstash_output_plugin.html#_test_installation_4))

  * Place the jar file in rocketmq_jar in /vendor/jar/rocketmq in the installation directory of LogStash

  * Put logstash-output-rocketmq-0.1.0.gem in the installation directory of LogStash

  * Run `bin/logstash-plugin install logstash-output-rocketmq-0.1.0.gem` in the installation directory of LogStash

* If the installation environment dose not have internet (Refer to [LogStash installing offline plugin packs](https://www.elastic.co/guide/en/logstash/current/offline-plugins.html#installing-offline-packs))

  * Place the jar file in rocketmq_jar in /vendor/jar/rocketmq in the installation directory of LogStash

  * Put logstash-offline-plugins-6.4.0.zip in the installation directory of LogStash

  * Run `bin/logstash-plugin install file:///path/to/logstash-offline-plugins-6.4.0.zip` in the installation directory of LogStash

## Configurations

|Option|Type|Description|Required?|Default|
|---|---|---|---|---|
|logstash_path|String|The installation directory of LogStash, e.g. C:/ELK/logstash, /usr/local/logstash|Yes||
|name_server_addr|String|Rocketmq's NameServer address, e.g. 192.168.10.10:5678|Yes||
|producer_group|String|Rocketmq's producer group|No|defaultProducerGroup|
|topic|String|Message's topic|Yes||
|tag|String|Message's tag|No|defaultTag|
|key|String|Message's key|No|defaultKey|
|retry_times|Number|Number of retries after failed delivery|No|2|

## Rewrite & Rebuild

The core file is [rocketmq.rb](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/lib/logstash/outputs/rocketmq.rb), if you have modified this file, you can run `gem build logstash-output-rocketmq.gemspec` to rebuild the gem file, or you can run `bin/logstash-plugin prepare-offline-pack logstash-output-rocketmq` to rebuild the offline packs (Refer to [LogStash building offline plugin packs](https://www.elastic.co/guide/en/logstash/current/offline-plugins.html#building-offline-packs))
