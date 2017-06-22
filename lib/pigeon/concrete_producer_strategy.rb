module Pigeon
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

	# Concrete producer strategy implementation of Publisher/Subscriber communication.
	class PubSubProducer < ProducerStrategy
		# Control the exchange of pubsub.
		# @return [Exchange] the exchange node that receive message and send to interested receivers.
		attr_accessor :exchange

		def initialize(hostname)
			super
		end

		# Set the name of exchange to start it.
		# @param exchange_name [String] the name of exchange that will be created.
		def setup(identifier)
			@exchange = @channel.fanout(identifier)
		end

		# Overwrite the method send to adapt to the context publisher/subscriber communication.
		def send(message)
			@exchange.publish(message)
			@connection.close
		end
	end
end
