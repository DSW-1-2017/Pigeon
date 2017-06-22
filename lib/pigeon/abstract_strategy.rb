module Pigeon
	# Strategy of producer.
	class ProducerStrategy
		include Connection
		# Created connection.
		attr_accessor :connection
		# Instance of channel from connection created.
		attr_accessor :channel

		# Start the connections and create a channel. The value default is localhost.
		# @param hostname [String] name of hostname to start the connection.
		def initialize(hostname='localhost')
			@connection = self.start hostname
			@channel = @connection.create_channel
		end

		# Abstract method to send a message.
		# @param message [String] the message do send to receiver.
		def send(message)
			raise NotImplementedError
		end
	end


	class ConsumerStrategy
		include Connection
		# Created connection.
		# @return (Connection) the connection started.
		attr_accessor :connection
		# Instace of channel from connection created.
		# @return [Channel] the channel created.
		attr_accessor :channel

		# Start the connections and create a channel. The value default is localhost.
		# @param hostname [String] name of hostname to start the connection.
		def initialize(hostname='localhost')
			@connection = self.start hostname
			@channel = @connection.create_channel
		end

		def listen_queue(queue)
			raise NotImplementedError
		end
	end
end