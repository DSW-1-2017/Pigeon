require_relative 'interface_message'
require_relative 'receive'
require 'bunny'

# This class implements simple connection mode
class Simple < InterfaceMessage
  def connect(receive)
    @connection = Bunny.new(hostname: receive.ip_address)
    @connection.start
    puts "connect simple #{receive.ip_address}"
  end

  def send(message, receive)
    connect(receive)
    channel = @connection.create_channel
    receive.send_simple(message, channel)
    @connection.close
  end
end
