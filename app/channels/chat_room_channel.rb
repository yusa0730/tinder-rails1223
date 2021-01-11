class ChatRoomChannel < ApplicationCable::Channel
  # subscribedでどのchannel(今回はchat_room_channel)を購読するか指定します。
  # このコードで、chat_room_channel.rbとchat_room_channel.jsでデータ送受信できます。
  def subscribed
    stream_from "chat_room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'chat_room_channel', chat_message: data['chat_message']
  end
end
