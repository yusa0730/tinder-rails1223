class ChatRoomUser < ApplicationRecord
  belongs_to :users
  belongs_to :chat_room
end
