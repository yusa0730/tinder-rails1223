class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  # データを保存した後に処理を書きたい場合、モデルにafter_create_commit等を使います。
  # データを保存後にChatMessageBroadcastJobを実行するようにしています。
  after_create_commit{ChatMessageBroadcastJob.perform_later self}
end
