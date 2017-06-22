module Pigeon
	require 'bunny'

	module Connection
		def start(hostname='localhost')
			@connection = Bunny.new(hostname: hostname)
	    	@connection.start
		end

		def close
			@connection.close
		end
	end

	# Context of strategies.
	class ProducerCommunication
		attr_accessor :simple, :pubsub

		def initialize(communication, hostname)
			case communication
			when :simple
				@simple = Pigeon::SimpleProducer.new(hostname)
			when :pubsub
				@pubsub = Pigeon::PubSubProducer.new(hostname)
			end
		end

		# def send(message, queue)
		# 	@simple.send(message, queue)
		# end
	end

	class ConsumerCommunication
		attr_accessor :simple, :pubsub
		# attr_accessor :queue

		def initialize(communication, hostname)
			case communication
			when :simple
				@simple = Pigeon::SimpleConsumer.new(hostname)
			when :pubsub
				@pubsub = Pigeon::PubSubConsumer.new(hostname)
			end
		end

		# def listen_queue(queue)
		# 	@queue = @simple.channel.queue(queue)
		# end
	end

	# Abstract Strategies.
	class ProducerStrategy
		include Connection
		attr_accessor :connection, :channel

		def initialize(hostname)
			@connection = self.start hostname
			@channel = @connection.create_channel
		end

		def send(message)
			raise NotImplementedError
		end
	end

	class ConsumerStrategy
		include Connection
		attr_accessor :connection, :channel

		def initialize(hostname='localhost')
			@connection = self.start hostname
			@channel = @connection.create_channel
		end

		def listen_queue(queue)
			raise NotImplementedError
		end
	end

	# Concrete Producer Strategies.
	class SimpleProducer < ProducerStrategy
		attr_accessor :queue

		def initialize(hostname)
			super
		end

		def set_queue(queue)
			@queue = @channel.queue(queue)
		end

		def send(message)
			@channel.default_exchange.publish(message, routing_key: @queue.name)
			@connection.close
		end
	end

	class PubSubProducer < ProducerStrategy
		attr_accessor :exchange

		def initialize(hostname)
			super
		end

		def set_exchange(exchange_name)
			@exchange = @channel.fanout(exchange_name)
		end

		def send(message)
			@exchange.publish(message)
			@connection.close
		end
	end

	# Concrete Consumer/Receiver Strategies
	class SimpleConsumer < ConsumerStrategy
		attr_accessor :queue

		def initialize(hostname)
			super
		end

		def listen_queue(queue)
			@channel.queue(queue)
		end
	end

	class PubSubConsumer< ConsumerStrategy
		attr_accessor :queue

		def initialize(hostname)
			super
			@queue = @channel.queue("", exclusive: true)
		end

		def create_bind(exchange_name)
			@exchange = @channel.fanout(exchange_name)
			@queue.bind(@exchange)
		end
	end
end