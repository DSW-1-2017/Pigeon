require_relative 'lib/receive.rb'
require_relative 'lib/message_list.rb'

ml = MessageList.new
rec = Receive.new('ligacao1', 'localhost')

# simple_message
ml.add_message('mensagem que será recebida no simple', rec, MessageList.simple)

# pub_sub_message
ml.add_message('mensagem que será recebida no p_s', rec, MessageList.pub_sub)

# send all messages
ml.send
