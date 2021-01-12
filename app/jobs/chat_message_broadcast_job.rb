class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # ブロードキャストの処理をしています。
    ActionCable.server.broadcast 'chat_room_channel', chat_message: render_chat_message(chat_message)
  end

  private
    def render_chat_message(chat_message)
      # ApplicationController.rendererでコントローラーの制約を受けずに、任意のビューテンプレートをレンダリングします。
      # 今回は、chat_messages/_chat_message.html.erbを呼び出しています。
      # localsオプションで、部分テンプレートで使える変数を定義しています。
      ApplicationController.renderer.render(partial: 'chat_messages/chat_message', locals: {chat_message: chat_message, current_user:chat_message.user})
    end
end
