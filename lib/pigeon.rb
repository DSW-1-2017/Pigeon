module Pigeon
	require 'bunny'

	module Connection
		# Create Template Method
		def self.create_connection(hostname)
			@connection = Bunny.new(hostname: hostname)
	    	@connection.start
		end

		def self.create_channel
			@channel = @connection.create_channel
		end
	end

	# Interface
	class MessageCommand
	  def send(message, receive)
	    raise NotImplementedError, 'method not implemented'
	  end
	end

	# This class has invoker of sender methods and has controll of executation
	class MessageInvoker
	  attr_accessor :interface_message
	  # message_type = [:simple, :pubsub]

	  def initialize
	    @interface_message = []
	  end

	  def send
	    @interface_message.each do |interface|
	      interface[:type].send(interface[:message], interface[:receive])
	    end
	  end
	  def add_message(message, receive, type)

	    case type
		    when :simple
		      hash = { type: Simple.new, message: message, receive: receive }
		    when :pubsub
		      hash = { type: PubSub.new, message: message, receive: receive }
		    else
		      raise NotImplementedError, 'type not implemented'
	    end

	    interface_message.push(hash)
	  end
	end

	# This class implements simple connection mode
	class Simple < MessageCommand
	  def connect(receive)
	    @connection = Bunny.new(hostname: receive.ip_address)
	    @connection.start
	    puts "connect simple #{receive.ip_address}"
	  end

	  def send(message, receive)
	    connect(receive)
	    channel = @connection.create_channel
	    receive.send_simple(message, channel)
	    @connection.close
	  end
	end

	# This class implements PubSub connection mode
	class PubSub < MessageCommand
	  def connect(receive)
	    puts "connect pub_sub #{receive.ip_address}"
	  end

	  def send(message, receive)
	    connect(receive)
	    receive.send_pubsub(message)
	  end
	end

	# This class contain configuration of receive and implementation methods
	# of communication
	class Receiver
		include Connection
	  attr_accessor :host
	  attr_accessor :call_name

	  # def initialize(call_name, host)
	  #   @call_name = call_name
	  #   @host = host
	  # end

	  def send_simple(message, queue)
	    queue = channel.queue(queue)
	    channel.default_exchange.publish(message, routing_key: queue.name)
	    puts "send simple '#{message}'"
	  end

	  def send_pubsub(message)
	    puts "send pub_sub '#{message}'"
	  end
	end
end