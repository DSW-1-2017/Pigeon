require "thread"

module Pigeon
  module Producer
    # Concrete producer strategy implementation of RPC communication.
    class RPCProducer < ProducerStrategy
      attr_reader :server_queue_name
      # RPC gives client a response (response) by an specific id (call_id)
      attr_accessor :response, :call_id
      # Mutexes to handler race conditions
      attr_reader :lock, :condition

      def initialize(hostname)
        super
        @reply_queue = @channel.queue("", :exclusive => true)
        @lock = Mutex.new
        @condition = ConditionVariable.new
      end

      # Set the name of exchange to start it.
      # @param identifier [String] the name of exchange that will be created.
      def setup(identifier)
        raise Error::IdentifierTypeError unless identifier.is_a? String
        @server_queue_name = identifier
        @exchange = @channel.default_exchange
      end

      # Overwrite the method send to adapt to the context publisher/subscriber communication.
      def send(message)
        raise Error::MessageTypeError unless message.is_a? String
        raise Error::ProducerSetupError if @exchange.nil?
        handle_response
        response = call(message)
        yield(response)
      end

      private
        # Method to generate a random identifier to the server's response
        # header
        def generate_uuid
          "#{rand}#{rand}#{rand}"
        end

        # Send a message and wait for a server's response signal
        def call(message)
          self.call_id = generate_uuid

          @exchange.publish(message,
            routing_key: @server_queue_name,
            correlation_id: self.call_id,
            reply_to: @reply_queue.name
          )

          lock.synchronize{condition.wait(lock)}
          self.response
        end

        # Create a recursive listener to execute yield block declared by
        # user for each message loaded from reply_queue.
        # RPC protocol gives clien a response according to the return of
        # the yield block on the server side. Block the mutex until there
        # is a response.
        def handle_response
          begin
            that = self
            @reply_queue.subscribe do |q_delivery_info, q_properties, q_response|
              if q_properties[:correlation_id] == that.call_id
                that.response = q_response
                that.lock.synchronize {that.condition.signal}
              end
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
