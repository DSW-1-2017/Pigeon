# This class contain configuration of receive and implementation methods
# of communication
class Receive
  attr_accessor :ip_address
  attr_accessor :call_name

  def initialize(call_name, ip_address)
    @call_name = call_name
    @ip_address = ip_address
  end

  def send_simple(message, channel)
    queue = channel.queue(@call_name)
    channel.default_exchange.publish(message, routing_key: queue.name)
    puts "send simple '#{message}'"
  end

  def send_pubsub(message)
    puts "send pub_sub '#{message}'"
  end
end
