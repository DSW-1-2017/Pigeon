require 'pigeon'
@producer = Pigeon::ProducerCommunication.new(:simple, 'localhost')

@producer.simple.send('hello')