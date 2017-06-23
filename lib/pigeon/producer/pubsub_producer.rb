module Pigeon
  module Producer
    # Concrete producer strategy implementation of Publisher/Subscriber communication.
    class PubSubProducer < ProducerStrategy
      # Control the exchange of pubsub.
      # @return [Exchange] the exchange node that receive message and send to interested receivers.
      attr_accessor :exchange

      def initialize(hostname)
        super
      end

      # Set the name of exchange to start it.
      # @param exchange_name [String] the name of exchange that will be created.
      def setup(identifier)
        @exchange = @channel.fanout(identifier)
      end

      # Overwrite the method send to adapt to the context publisher/subscriber communication.
      def send(message)
        @exchange.publish(message)
        @connection.close
      end
    end
  end
end
