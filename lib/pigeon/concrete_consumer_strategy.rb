module Pigeon
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

	# Concrete receiver strategy implementation of Publisher/Subscriber communication.
	class PubSubConsumer< ConsumerStrategy
		# Control the queue of receivers messages to consumer bind. 
		attr_accessor :queue

		# Further os initialize to connect, this construct start a queue
		def initialize(hostname)
			super
			@queue = @channel.queue("", exclusive: true)
		end

		# Create the bind to exchange where receiver the messages sends by producer.
		# @param exchange_name [String] the name of exchange to create it.
		def listen(identifier)
			@exchange = @channel.fanout(identifier)
			@queue.bind(@exchange)
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
