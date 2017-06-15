require_relative 'interface_message'
require_relative 'receive'

class Simple < InterfaceMessage

  def connect(receive)
    puts "connect simple #{receive.ip_address}"
  end

  def send(message, receive)
    connect(receive)
    receive.send_simple(message)
  end
end
