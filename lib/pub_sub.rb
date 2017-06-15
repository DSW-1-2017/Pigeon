require_relative 'interface_message'

class PubSub < InterfaceMessage

  def connect(receive)
    puts "connect pub_sub #{receive.ip_address}"
  end

  def send(message, receive)
    connect(receive)
    receive.send_pubsub(message)
  end
end
