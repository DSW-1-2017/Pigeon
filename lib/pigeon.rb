require 'pigeon/connection'
require 'pigeon/abstract_strategy'
require 'pigeon/concrete_producer_strategy'
require 'pigeon/concrete_consumer_strategy'

module Pigeon
	require 'bunny'

	# Context of producers strategies. The client that send a message use this.
	class ProducerCommunication
		# Communication of type simple.
		attr_accessor :simple
		# Communication of type pubsub.
		attr_accessor :pubsub

		# @param communication [Symbol] The type of communication to send and receive messages.
		# @param hostname [String] name of host do connect with the other module.
		def initialize(communication, hostname)
			create_producer(communication, hostname)
		end

		private
		def create_producer(communication_type, hostname)
			case communication_type
			when :simple
				@simple = Pigeon::SimpleProducer.new(hostname)
			when :pubsub
				@pubsub = Pigeon::PubSubProducer.new(hostname)
			end
		end
	end

	# Context of consumers strategies. The client that receive a message must to use this.
	class ConsumerCommunication
		# Receiver of type simple.
		attr_accessor :simple
		# Communication of type pubsub.
		attr_accessor :pubsub

		# @param communication [Symbol] The type of communication to send and receive messages.
		# @param hostname [String] name of host do connect with the other module.
		def initialize(communication, hostname)
			create_consumer(communication, hostname)
		end

		private
		def create_consumer(communication_type, hostname)
			case communication_type
			when :simple
				@simple = Pigeon::SimpleConsumer.new(hostname)
			when :pubsub
				@pubsub = Pigeon::PubSubConsumer.new(hostname)
			end
		end
	end
end