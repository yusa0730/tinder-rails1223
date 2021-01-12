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
    ChatMessage.create!(
      content: data['chat_message'],
      user_id: current_user.id,
      chat_room_id: data['chat_room_id']
    )
  end
end
