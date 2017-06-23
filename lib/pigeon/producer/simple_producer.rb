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
      # @param identifier [String] set the name of queue to created it.
      def setup(identifier)
        raise Error::IdentifierTypeError unless identifier.is_a? String
        @queue = @channel.queue(identifier)
      end

      # Overwrite the send method of superclass ProducerStrategy to simple
      # communication algorithm.
      # @param message [String] the message to be send to receiver.
      def send(message)
        raise Error::MessageTypeError unless message.is_a? String
        raise Error::ProducerSetupError if @queue.nil?
        @channel.default_exchange.publish(message, routing_key: @queue.name)
        @connection.close
      end
    end
  end
end
