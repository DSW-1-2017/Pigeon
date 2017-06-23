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

      # Start the connections and create a channel. The value default is localhost.
      # @param hostname [String] name of hostname to start the connection.
      def initialize(hostname='localhost')
        @connection = self.start hostname
        @channel = @connection.create_channel
      end

      def listen(identifier)
        raise NotImplementedError
      end

      def subscribe
        raise NotImplementedError
      end
    end
  end
end
