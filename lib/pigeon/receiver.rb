require 'pigeon'

@receiver = Pigeon::ConsumerCommunication.new(:simple, 'localhost')

@queue = @receiver.listen_queue 

@queue.subscribe(block: true) do |delivery_info, propertties, body|
	puts " [x] received #{body}"

	delivery_info.consumer.cancel
end