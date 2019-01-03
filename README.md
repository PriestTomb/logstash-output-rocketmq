# logstash-output-rocketmq

LogStash output 插件的 Rocketmq 版

## 说明

本人对 LogStash、Rocketmq、Ruby 都不是很熟，因为目前官方和民间暂时没找到有 Rocketmq 版的 output 插件，**这仅仅是为了工作需求临时参考学习写的一个基本 Demo**，所以连插件的 Rspec 测试文件都没写，分享出来仅供参考，如需实际应用，可重写核心代码

参考学习了 LogStash 的部分官方/非官方插件源码：[logstash-output-kafka](https://github.com/logstash-plugins/logstash-output-kafka)、[logstash-output-rabbitmq](https://github.com/logstash-plugins/logstash-output-rabbitmq)、[logstash-output-jdbc](https://github.com/theangryangel/logstash-output-jdbc)

## 版本

Demo 版基于 LogStash v6.4 和 Rocketmq Client v4.2 实现，其余版本未知

## 安装

0. 将 logstash-output-rocketmq-0.1.0.gem 放到 LogStash 的安装目录下

1. 在 LogStash 的安装目录下执行 `bin/logstash-plugin install logstash-output-rocketmq-0.1.0.gem`

2. 将 rocketmq_jar 中的 jar 文件放到 LogStash 安装目录下的 /vendor/jar/rocketmq 中

## 配置参数

|参数|类型|描述|是否必需|默认值|
|---|---|---|---|---|
|logstash_path|String|本地 Logstash 的路径，如 C:/ELK/logstash、/usr/local/logstash|是||
|name_server_addr|String|Rocketmq 的 NameServer 地址，如 192.168.10.10:5678|是||
|producer_group|String|Rocketmq 的 producer group|否|defaultProducerGroup|
|topic|String|Message 的 topic|是||
|tag|String|Message 的 tag|否|defaultTag|
|retry_times|Number|发送异常后的重试次数|否|2|

## 重写编译

核心文件仅为 [rocketmq.rb](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/lib/logstash/outputs/rocketmq.rb)，如果有修改，可重新使用 `gem build logstash-output-rocketmq.gemspec` 编译，后重新安装

如果仅少量修改测试，可直接在 LogStash 下安装好的插件内修改该文件（路径为/vendor/local_gems/xxxxxx），修改后重启 LogStash 即可
