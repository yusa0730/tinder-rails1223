class UsersController < ApplicationController
  # before_actionはメソッドを実行する前にフィルターをかけるメソッド
  before_action :authenticate_user!
  def show
    # インスタンス変数はviewに渡せる変数
    @user = User.find(params[:id])
  end

  def index
    # where.notで条件にマッチしないレコードを全て返します。
    # SELECT * FROM User WHERE (user.id != current_user.id)
    @users = User.where.not(id: current_user.id)
    @user = User.find(current_user.id)
  end
end
