class Receive
  attr_accessor :ip_address
  attr_accessor :call_name

  def initialize(call_name, ip_address)
    @call_name = call_name
    @ip_address = ip_address
  end

  def send_simple(message)
    puts "send simple '#{message}'"
  end

  def send_pubsub(message)
    puts "send pub_sub '#{message}'"
  end
end
