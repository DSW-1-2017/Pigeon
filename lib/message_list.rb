require_relative 'simple.rb'
require_relative 'pub_sub.rb'
# rubocop:disable Style/ClassVars
# This class has invoker of sender methods and has controll of executation
class MessageList
  attr_accessor :interface_message
  @@simple = 0
  @@pub_sub = 1

  def self.simple
    @@simple
  end

  def self.pub_sub
    @@pub_sub
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
    hash = {}

    case type
    when 0
      hash = { type: Simple.new, message: message, receive: receive }
    when 1
      hash = { type: PubSub.new, message: message, receive: receive }
    else
      raise NotImplementedError, 'type not implemented'
    end

    interface_message.push(hash)
  end
end
# rubocop:enable Style/ClassVars
