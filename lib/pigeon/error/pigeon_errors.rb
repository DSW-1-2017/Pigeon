module Pigeon
  module Error
    class HostnameTypeError < TypeError
      def initialize(msg="Hostname should be a valid string")
        super(msg)
      end
    end

    class IdentifierTypeError < TypeError
      def initialize(msg="Identifier should be a valid string")
        super(msg)
      end
    end

    class MessageTypeError < TypeError
      def initialize(msg="Message should be a valid string")
        super(msg)
      end
    end

    class ProducerSetupError < StandardError
      def initialize(msg="You should setup producer first")
        super(msg)
      end
    end

    class ConsumerSetupError < StandardError
      def initialize(msg="You should setup consumer first")
        super(msg)
      end
    end

    class UnexpectedInterruption < StandardError
      def initialize(msg="Connection closed by an interruption")
        super(msg)
      end
    end

    class InvalidProducerType < StandardError
      def initialize(msg="You should specify a valid communicator")
        super(msg)
      end
    end

    class InvalidConsumerType < StandardError
      def initialize(msg="You should specify a valid communicator")
        super(msg)
      end
    end
  end
end
