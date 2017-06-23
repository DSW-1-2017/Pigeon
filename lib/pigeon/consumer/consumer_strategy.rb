module Pigeon
  module Consumer
    class ConsumerStrategy
      include Library::Connection
      # Created connection.
      # @return (Connection) the connection started.
      attr_accessor :connection
      # Instace of channel from connection created.
      # @return [Channel] the channel created.
      attr_accessor :channel

      # Start the connections and create a channel.
      # The value default is localhost.
      # @param hostname [String] name of hostname to start the connection.
      def initialize(hostname='localhost')
        raise Error::HostnameTypeError unless hostname.is_a? String
        @connection = self.start hostname
        @channel = @connection.create_channel
      end

      # Should be implemented to setup the server's configuration.
      def listen(identifier)
        raise NotImplementedError
      end

      # Should be implemented to wait messages from a producer
      def subscribe
        raise NotImplementedError
      end
    end
  end
end
