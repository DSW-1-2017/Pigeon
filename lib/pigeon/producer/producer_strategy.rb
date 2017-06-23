module Pigeon
  module Producer
    # Strategy of producer.
    class ProducerStrategy
      include Library::Connection
      # Created connection.
      attr_accessor :connection
      # Instance of channel from connection created.
      attr_accessor :channel

      # Start the connections and create a channel. The value default is localhost.
      # @param hostname [String] name of hostname to start the connection.
      def initialize(hostname='localhost')
        raise Error::HostnameTypeError unless hostname.is_a? String
        @connection = self.start hostname
        @channel = @connection.create_channel
      end

      # Abstract method to send a message.
      # @param message [String] the message do send to receiver.
      def send(message)
        raise NotImplementedError
      end

      # Abstract method to setup client configuration according to the
      # specification of the server.
      # @param identifier [String] a parameter to match some configurations
      # on the server side.
      def setup(identifier)
        raise NotImplementedError
      end
    end
  end
end
