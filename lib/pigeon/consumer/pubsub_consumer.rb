module Pigeon
  module Consumer
    # Concrete receiver strategy implementation of Publisher/Subscriber
    # communication.
    class PubSubConsumer< ConsumerStrategy
      # Control the queue of receivers messages to consumer bind.
      attr_accessor :queue

      # Further os initialize to connect, this construct start a queue
      def initialize(hostname)
        super
        @queue = @channel.queue("", exclusive: true)
      end

      # Create the bind to exchange where receiver the messages sends
      # by producer.
      # @param identifier [String] the name of exchange to create it.
      def listen(identifier)
        raise Error::IdentifierTypeError unless identifier.is_a? String
        @exchange = @channel.fanout(identifier)
        @queue.bind(@exchange)
      end

      # Create a recursive listener to execute yield block declared by
      # user for each message loaded from queue.
      def subscribe
        raise Error::ConsumerSetupError if @exchange.nil?
        begin
          @queue.subscribe(block: true) do |q_delivery_info, q_properties, q_body|
            yield(q_delivery_info, q_properties, q_body)
          end
        rescue Interrupt => _
          @channel.close
          @connection.close
          raise Error::UnexpectedInterruption
        end
      end
    end
  end
end
