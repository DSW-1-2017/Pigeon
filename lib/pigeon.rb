require 'pigeon/error/pigeon_errors'
require 'pigeon/lib/connection'
require 'pigeon/consumer/consumer_strategy'
require 'pigeon/consumer/simple_consumer'
require 'pigeon/consumer/pubsub_consumer'
require 'pigeon/consumer/rpc_consumer'
require 'pigeon/producer/producer_strategy'
require 'pigeon/producer/simple_producer'
require 'pigeon/producer/pubsub_producer'
require 'pigeon/producer/rpc_producer'

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
				@communicator = Producer::SimpleProducer.new(hostname)
			when :pubsub
				@communicator = Producer::PubSubProducer.new(hostname)
			when :rpc
				@communicator = Producer::RPCProducer.new(hostname)
      else
        raise Error::InvalidProducerType
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
				@communicator = Consumer::SimpleConsumer.new(hostname)
			when :pubsub
				@communicator = Consumer::PubSubConsumer.new(hostname)
			when :rpc
				@communicator = Consumer::RPCConsumer.new(hostname)
      else
        raise Error::InvalidConsumerType
			end
		end
	end
end
