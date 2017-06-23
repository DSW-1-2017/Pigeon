require_relative 'lib/pigeon.rb'

#Example
#You only need to change :simple to :pubsub in client.rb and server.rb
receiver = Pigeon::ConsumerCommunication.new(:rpc, 'localhost')
receiver.communicator.listen('x')
receiver.communicator.subscribe do |info, properties, body|
  puts "[X] #{body}"
  "Server's response!"
end
