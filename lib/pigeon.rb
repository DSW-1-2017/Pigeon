module Pigeon
	module MessageList

	end

	class Message
		def send(message)
			raise "Not implemented"
		end
	end

	# Simple algothm to send messages.
	class Simple < Message
		def connect
		end

		def send(message)
		end
	end

	# Algorithm Publisher Subscriber
	class PubSub < Message
		def connect
		end

		def send(message)
		end
	end

	module Component
		def send_simple(message)
		end

		def send_pubsub(message)
		end
	end
end