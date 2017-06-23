module Pigeon
  module Producer
    # Concrete strategy implementation of simple communication.
    class SimpleProducer < ProducerStrategy
      # @return [Queue] the queue created from channel.
      attr_accessor :queue

      def initialize(hostname)
        super
      end

      # Set the name of queue for communications.
      # @param queue [String] set the name of queue to created it. 
      def setup(identifier)
        @queue = @channel.queue(identifier)
      end

      # Overwrite the send method of superclass ProducerStrategy to simple communication algorithm.
      # @param message [String] the message to be send to receiver.
      def send(message)
        @channel.default_exchange.publish(message, routing_key: @queue.name)
        @connection.close
      end
    end
  end
end
