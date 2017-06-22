require_relative 'lib/pigeon.rb'

#Example
#You only need to change :simple to :pubsub in client.rb and server.rb
producer = Pigeon::ProducerCommunication.new(:simple, 'localhost')
producer.communicator.setup('x')
producer.communicator.send("hello")
