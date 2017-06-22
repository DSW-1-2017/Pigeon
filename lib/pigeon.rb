require 'pigeon/connection'
require 'pigeon/abstract_strategy'
require 'pigeon/concrete_producer_strategy'
require 'pigeon/concrete_consumer_strategy'

module Pigeon
	require 'bunny'

	# Context of producers strategies. The client that send a message use this.
	class ProducerCommunication
		attr_accessor :communicator

		# @param communication [Symbol] The type of communication to send and receive messages.
		# @param hostname [String] name of host do connect with the other module.
		def initialize(communication, hostname)
			create_producer(communication, hostname)
		end

		private
		def create_producer(communication_type, hostname)
			case communication_type
			when :simple
				@communicator = Pigeon::SimpleProducer.new(hostname)
			when :pubsub
				@communicator = Pigeon::PubSubProducer.new(hostname)
			end
		end
	end

	# Context of consumers strategies. The client that receive a message must to use this.
	class ConsumerCommunication
		attr_accessor :communicator

		# @param communication [Symbol] The type of communication to send and receive messages.
		# @param hostname [String] name of host do connect with the other module.
		def initialize(communication, hostname)
			create_consumer(communication, hostname)
		end

		private
		def create_consumer(communication_type, hostname)
			case communication_type
			when :simple
				@communicator = Pigeon::SimpleConsumer.new(hostname)
			when :pubsub
				@communicator = Pigeon::PubSubConsumer.new(hostname)
			end
		end
	end
end
