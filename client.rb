require_relative 'lib/receive.rb'
require_relative 'lib/message_list.rb'

ml = MessageList.new
rec = Receive.new('ligacao1','192.168.2.1')

#simple_message
ml.add_message('mensagem que será recebida no simple', rec, MessageList.simple)

#pub_sub_message
ml.add_message('mensagem que será recebida no pub_sub', rec, MessageList.pub_sub)

# send all messages
ml.send
