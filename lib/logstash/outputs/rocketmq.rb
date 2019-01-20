# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "java"

# Rocketmq 版 LogStash Output 插件，根据 Rocketmq v4.2 开发，实现方式较为简陋
# 将 Rocketmq 官方客户端依赖 jar 包放 LogStash 根目录下的 /vendor/jar/rocketmq 目录中即可
class LogStash::Outputs::Rocketmq < LogStash::Outputs::Base

  # 设置插件可多线程并发执行
  concurrency :shared

  config_name "rocketmq"

  # 本地 Logstash 的路径，必需，如 C:/ELK/logstash、/usr/local/logstash
  config :logstash_path, :validate => :string, :required => true

  # Rocketmq 的 NameServer 地址，必需，如 192.168.10.10:5678
  config :name_server_addr, :validate => :string, :required => true

  # Rocketmq 的 producer group
  config :producer_group, :validate => :string, :default => "defaultProducerGroup"

  # Message 的 topic，必需
  config :topic, :validate => :string, :required => true

  # Message 的 tag
  config :tag, :validate => :string, :default => "defaultTag"

  # Message 的 key
  config :key, :validate => :string, :default => "defaultKey"

  # 发送异常后的重试次数，默认 2 次
  config :retry_times, :validate => :number, :default => 2

  def register
    load_jar_files

    @stopping = Concurrent::AtomicBoolean.new(false)

    # 创建生产者对象
    @producer = org.apache.rocketmq.client.producer.DefaultMQProducer.new(producer_group)
    @producer.setNamesrvAddr(name_server_addr)
    @producer.start
  end

  def multi_receive(events)
    return if events.empty?
    events.each do |event|
      retrying_send(event)
    end
  end

  # 加载依赖的 jar 文件
  def load_jar_files
    jarpath = logstash_path + "/vendor/jar/rocketmq/*.jar"
    @logger.info("RocketMq plugin required jar files are loadding... Jar files path: ", path: jarpath)

    jars = Dir[jarpath]
    raise LogStash::ConfigurationError, 'RocketMq plugin init error, no jars found! Please check the jar files path!' if jars.empty?

    jars.each do |jar|
      @logger.trace('RocketMq plugin loaded a jar: ', jar: jar)
      require jar
    end
  end

  def retrying_send(event)
    sent_times = 0

    begin
      # 配置 message 对象
      mq_message = org.apache.rocketmq.common.message.Message.new
      mq_message.setTopic(topic)
      mq_message.setTags(tag)
      mq_message.setKeys(key)
      mq_message.setBody("#{event}".bytes)
      result = @producer.send(mq_message)

      if result.nil?
        raise "Send message error! Result is null."
      end

      if org.apache.rocketmq.client.producer.SendStatus::SEND_OK != result.getSendStatus
        status_name = result.getSendStatus.name
        raise "Send message error! Result code is #{status_name}"
      end
    rescue => e
      @logger.error('An Exception Occured!!',
                    :message => e.message,
                    :exception => e.class)
      if @stopping.false? and (sent_times < retry_times)
        # 重试
        sent_times += 1
        retry
      else
        # 根据实际需求处理没发送成功的消息
        puts "Message send failed: #{event}"
      end
    end
  end

  def close
    @stopping.make_true
    @producer.shutdown
  end

end
