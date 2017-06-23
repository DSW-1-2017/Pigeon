require_relative 'lib/pigeon.rb'

#Example
#You only need to change :simple to :pubsub or :rpc in client.rb and server.rb
producer = Pigeon::ProducerCommunication.new(:simple, 'localhost')
producer.communicator.setup('x')
producer.communicator.send("hello")

# If you want to get a response from server, initialize both producer and
# consumer using :rpc protocol and you'll be able to use a block to handle
# server's response.
#
# Example:
# producer.communicator.send("hello") do |response|
#   puts response
# end
