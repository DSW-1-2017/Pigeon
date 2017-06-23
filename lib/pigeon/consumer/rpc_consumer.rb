module Pigeon
  module Consumer
    # Concrete receiver strategy implementation of Publisher/Subscriber communication.
    class RPCConsumer < ConsumerStrategy
      # Further os initialize to connect, this construct start a queue
      def initialize(hostname)
        super
        @queue = @channel.queue("", exclusive: true)
      end

      # Create the bind to exchange where receiver the messages sends by producer.
      # @param exchange_name [String] the name of exchange to create it.
      def listen(identifier)
        raise Error::IdentifierTypeError unless identifier.is_a? String
        @queue = @channel.queue(identifier)
        @exchange = @channel.default_exchange
      end

      # Create a recursive listener to execute yield block declared by
      # user for each message loaded from queue.
      # RPC protocol gives clien a response according to the return of
      # the yield block.
      def subscribe
        raise Error::ConsumerSetupError if @queue.nil?
        raise Error::ConsumerSetupError if @exchange.nil?
        begin
          @queue.subscribe(block: true) do |q_delivery_info, q_properties, q_body|
            response = yield(q_delivery_info, q_properties, q_body)
            @exchange.publish(
              response.to_s,
              routing_key: q_properties.reply_to,
              correlation_id: q_properties.correlation_id
            )
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
