module Pigeon
	require 'bunny'

	module Connection
		def start(hostname)
			@connection = Bunny.new(hostname: hostname)
	    	@connection.start
		end

		def close
			@connection.close
		end
	end

	# Context of strategies.
	class ProducerCommunication
		attr_accessor :simple

		def initialize(communication, hostname)
			case communication
			when :simple
				@simple = Pigeon::SimpleProducer.new(hostname)
			when :pubsub
			end
		end

		def send(message, queue)
			@simple.send(message, queue)
		end
	end

	class ConsumerCommunication
		attr_accessor :simple
		attr_accessor :queue

		def initialize(communication, hostname)
			case communication
			when :simple
				@simple = Pigeon::SimpleProducer.new(hostname)
			when :pubsub
			end
		end

		def listen_queue(queue)
			@queue = @simple.channel.queue(queue)
		end
	end

	# Abstract Strategies.
	class ProducerStrategy
		include Connection
		attr_accessor :connection, :channel

		def initialize(hostname)
			@connection = self.start hostname
			@channel = @connection.create_channel
		end

		def send(message, queue)
			raise NotImplementedError
		end

		def create_queue(queue)
			raise NotImplementedError
		end
	end

	class ConsumerStrategy
		include Connection
		attr_accessor :connection, :channel

		def initialize(hostname)
			@connection = self.start hostname
			@channel = @connection.create_channel
		end

		def listen_queue(queue)
			raise NotImplementedError
		end
	end

	# Concrete Producer Strategies.
	class SimpleProducer < ProducerStrategy
		
		def initialize(hostname)
			super
		end

		def send(message, queue)
			queue = @channel.queue(queue)
			@channel.default_exchange.publish(message, routing_key: queue.name)
		end
	end

	class PubSubProducer < ProducerStrategy
	end

	# Concrete Consumer/Receiver Strategies
	class SimpleConsumer < ConsumerStrategy
		
		def initialize(hostname)
			super
		end

		def listen_queue(queue)
			@channel.queue(queue)
		end
	end

	class PubSubConsumer< ConsumerStrategy
	end
end