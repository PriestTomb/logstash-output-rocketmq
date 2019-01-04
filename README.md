# logstash-output-rocketmq

LogStash plugin output to Rocketmq

[中文说明](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/README_zh.md)

## Description

I am not skilled in LogStash, Rocketmq and Ruby, just because there are no official or third-party rocketmq output plugin found on the web. **This is just a demo written for work needs**, so the Rspec file is not written. Share the code for reference only, if you want to use it, please rewrite the core code.

Learned the source code of some LogStash output plugins: [logstash-output-kafka](https://github.com/logstash-plugins/logstash-output-kafka), [logstash-output-rabbitmq](https://github.com/logstash-plugins/logstash-output-rabbitmq), [logstash-output-jdbc](https://github.com/theangryangel/logstash-output-jdbc)

## Versions

This demo is based on LogStash v6.4 and Rocketmq Client v4.2, other versions are not clear.

## Installation

0. Put logstash-output-rocketmq-0.1.0.gem in the installation directory of LogStash

1. Run `bin/logstash-plugin install logstash-output-rocketmq-0.1.0.gem` in the installation directory of LogStash

2. Place the jar file in rocketmq_jar in /vendor/jar/rocketmq in the installation directory of LogStash

## Configurations

|Option|Type|Description|Required?|Default|
|---|---|---|---|---|
|logstash_path|String|The installation directory of LogStash, e.g. C:/ELK/logstash, /usr/local/logstash|Yes||
|name_server_addr|String|Rocketmq's NameServer address, e.g. 192.168.10.10:5678|Yes||
|producer_group|String|Rocketmq's producer group|No|defaultProducerGroup|
|topic|String|Message's topic|Yes||
|tag|String|Message's tag|No|defaultTag|
|retry_times|Number|Number of retries after failed delivery|No|2|

## Rewrite & Rebuild

The core file is [rocketmq.rb](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/lib/logstash/outputs/rocketmq.rb), if you have modified this file, you can run `gem build logstash-output-rocketmq.gemspec` to rebuild the gem file, then re-install.

But if only a small amount of modification is in order to test, you can modify this file directly in the plugin installed under LogStash (plugin path is /vendor/local_gems/xxxxxx), restart LogStash after modification.
