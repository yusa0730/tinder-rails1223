class UsersController < ApplicationController
  # before_actionはメソッドを実行する前にフィルターをかけるメソッド
  before_action :authenticate_user!
  def show
    # インスタンス変数はviewに渡せる変数
    @user = User.find(params[:id])
  end
end
