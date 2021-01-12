module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # chat_room_channel.rb ではcurrent_userを使うことはできません。
    # そのため、app/channels/application_cable/connection.rbでcurrent_userを使うためのコードを書く必要があります。
    # identified_byはコネクション(クライアントとサーバー間の関係を成立させる基礎)を識別するキーです。
    identified_by :current_user

    def connect
      # WebSocket接続が開いている場合は閉じ、404を返します。
      rejecta_unauthorized_connection unless find_verified_user
    end 

    private
    def find_verified_user
      # ログインしているユーザーの情報を取得できます。
      self.current_user = env['warden'].user
    end
  end
end
