require_relative 'simple.rb'
require_relative 'pub_sub.rb'

class MessageList
  attr_accessor :interface_message
  @@SIMPLE = 0
  @@PUBSUB = 1

  def self.simple
    @@SIMPLE
  end

  def self.pub_sub
    @@PUBSUB
  end

  def initialize
    @interface_message = []
  end

  def send
    @interface_message.each do |interface|
      interface[:type].send(interface[:message], interface[:receive])
    end
  end

  # type = 0 => simple, 1 => pubsub
  def add_message(message, receive, type)
    hash = Hash.new

    case type
    when 0
      hash = {type: Simple.new, message: message, receive:receive}
    when 1
      hash = {type: PubSub.new, message: message, receive:receive}
    else
      fail NotImplementedError, "type not implemented"
    end

    interface_message.push(hash)
  end
end
