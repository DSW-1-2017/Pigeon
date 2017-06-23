require_relative 'lib/pigeon.rb'

#Example
#You only need to change :simple to :pubsub in client.rb and server.rb
receiver = Pigeon::ConsumerCommunication.new(:simple, 'localhost')
receiver.communicator.listen('x')

# To send a response to client, you should use :rpc protocol
receiver.communicator.subscribe do |info, properties, body|
  puts "[X] #{body}"
  "Server's response!"
end
