module Pigeon
  module Consumer
    # Concrete receiver strategy implementation of Simple communication.
    class SimpleConsumer < ConsumerStrategy
      # Control the queue between producer and consumer.
      # @return [Queue] the queue that control messages.
      attr_accessor :queue

      def initialize(hostname)
        super
      end

      # Set the queue that consumer will be wait messages.
      # @param queue [String] the name of queue.
      def listen(identifier)
        @queue = @channel.queue(identifier)
      end

      def subscribe
        begin
          @queue.subscribe(block: true) do |q_delivery_info, q_properties, q_body|
            yield(q_delivery_info, q_properties, q_body)
          end
        rescue Interrupt => _
          @channel.close
          @connection.close
        end
      end
    end
  end
end
