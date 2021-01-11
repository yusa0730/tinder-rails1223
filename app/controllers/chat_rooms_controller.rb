class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  # チャットルームを作成する大まかなロジックとしては、以下になります。
  # 1.自分がいるチャットルームを取得
  # 2.自分がいるチャットルームからマッチング一覧ページからクリックしたユーザーがいるチャットルームを取得
  # 3.2でチャットルームが存在しなければチャットルームを作成
  # 4.チャットルームに遷移

  def create
    # 1.自分がいるチャットルームを取得
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room)
    # 2.自分がいるチャットルームからマッチング一覧ページからクリックしたユーザーがいるチャットルームを取得
    chat_room = ChatRoomUser.where(chat_room_id: current_user_chat_rooms, user_id: params[:user_id]).map(&:chat_room).first
    # chat_roomがなければ、チャットルームを作成する処理をするように条件式を書いています。
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room: chat_room, user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room, user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room.id
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    # binding.pry
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user
    @chat_messages = ChatMessage.where(chat_room: @chat_room)
  end
end
