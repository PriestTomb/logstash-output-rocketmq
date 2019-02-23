# logstash-output-rocketmq

LogStash output 插件的 Rocketmq 版

[README](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/README.md)

## 说明

本人对 LogStash、Rocketmq、Ruby 都不是很熟，因为目前官方和民间暂时没找到有 Rocketmq 版的 output 插件，**这仅仅是为了工作需求临时参考学习写的一个基本 Demo**，所以连插件的 Rspec 测试文件都没写，分享出来仅供参考，如需实际应用，可重写核心代码

参考学习了 LogStash 的部分官方/非官方插件源码：[logstash-output-kafka](https://github.com/logstash-plugins/logstash-output-kafka)、[logstash-output-rabbitmq](https://github.com/logstash-plugins/logstash-output-rabbitmq)、[logstash-output-jdbc](https://github.com/theangryangel/logstash-output-jdbc)

## 版本

Demo 版基于 LogStash v6.4 和 Rocketmq Client v4.2 实现，其余版本未知

## 更新日志

#### [v0.1.3] 2019-02-23

* 引入 codec 插件，调整 `multi_receive` 方法为 `multi_receive_encoded` 方法，使 rocketmq 插件可配置 codec 插件，对接收的消息进行自定义格式化

* 修复消息中有中文时，Ruby 的 byte 数组转换成 Java 的 byte 数组会出现越界异常的 bug

#### [v0.1.2] 2019-01-20

* 修复 message 对象被定义为实例变量在多线程下会出现 `the message body is null` 报错的 bug

#### [v0.1.1] 2019-01-19

* 新增配置参数 `key`，即 Rocketmq Message 对象的 key 参数

* 补充插件的 `concurrency :shared` 设置，否则不能多 workers 并发处理消息

* 修复 event 对象转 byte 数组时偶尔会崩溃的 bug

* 修复重试次数有误的 bug

#### [v0.1.0] 2019-01-03

* 仅仅是一个能跑的 Demo 版

## 安装

* 如果安装环境有网络（参考[ LogStash 插件测试安装](https://www.elastic.co/guide/en/logstash/current/_how_to_write_a_logstash_output_plugin.html#_test_installation_4)）

  * 将 rocketmq_jar 中的 jar 文件放到 LogStash 安装目录下的 /vendor/jar/rocketmq 中
  * 将 logstash-output-rocketmq-0.1.0.gem 放到 LogStash 的安装目录下
  * 在 LogStash 的安装目录下执行 `bin/logstash-plugin install logstash-output-rocketmq-0.1.0.gem`

* 如果安装环境无网络（参考[ LogStash 插件离线安装](https://www.elastic.co/guide/en/logstash/current/offline-plugins.html#installing-offline-packs)）

  * 将 rocketmq_jar 中的 jar 文件放到 LogStash 安装目录下的 /vendor/jar/rocketmq 中
  * 将 logstash-offline-plugins-6.4.0.zip 放到 LogStash 的安装目录下
  * 在 LogStash 的安装目录下执行 `bin/logstash-plugin install file:///path/to/logstash-offline-plugins-6.4.0.zip`

## 配置参数

|参数|类型|描述|是否必需|默认值|
|---|---|---|---|---|
|logstash_path|String|本地 Logstash 的路径，如 C:/ELK/logstash、/usr/local/logstash|是||
|name_server_addr|String|Rocketmq 的 NameServer 地址，如 192.168.10.10:5678|是||
|producer_group|String|Rocketmq 的 producer group|否|defaultProducerGroup|
|topic|String|Message 的 topic|是||
|tag|String|Message 的 tag|否|defaultTag|
|key|String|Message 的 key|否|defaultKey|
|retry_times|Number|发送异常后的重试次数|否|2|
|codec|Object|Logstash 的 codec 插件配置|否|plain|

## 重写编译

插件的核心文件仅为 [rocketmq.rb](https://github.com/PriestTomb/logstash-output-rocketmq/blob/master/lib/logstash/outputs/rocketmq.rb)，如果有修改，可重新使用 `gem build logstash-output-rocketmq.gemspec` 编译 gem 文件，或使用 `bin/logstash-plugin prepare-offline-pack logstash-output-rocketmq` 打包离线插件包（参考[ LogStash 打包离线插件包](https://www.elastic.co/guide/en/logstash/current/offline-plugins.html#building-offline-packs)）
