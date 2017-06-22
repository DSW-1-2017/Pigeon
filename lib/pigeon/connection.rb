module Pigeon
	# Module responsible for connections with the RabbitMQ.
	module Connection
		# Create a connection and start it.
		# 
		# == Parameters:
		# format::
		# 	A string with the name of host to connect. The default argument is localhost`
		# 
		# == Returns:
		# A connection initialized from bunny.
		def start(hostname='localhost')
			@connection = Bunny.new(hostname: hostname)
      @connection.start
		end

		# Close an open connection.
		# 
		# == Returns:
		# The connection closed.
		def close
			@connection.close
		end
	end
end
