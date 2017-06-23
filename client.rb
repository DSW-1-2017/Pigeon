require_relative 'lib/pigeon.rb'

#Example
#You only need to change :simple to :pubsub in client.rb and server.rb
producer = Pigeon::ProducerCommunication.new(:rpc, 'localhost')
producer.communicator.setup('x')
producer.communicator.send("hello") do |response|
  puts response
end
