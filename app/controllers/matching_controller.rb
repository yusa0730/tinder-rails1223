class MatchingController < ApplicationController
  before_action :authenticate_user!

  def index
    #「相手は自分にいいねをしている」 かつ 「いいねをしてくれた相手に自分もいいねをしている」情報を引っ張ってくる
    # 欲しい情報としては、自分にいいねをした人のuser_idだけでいいのでpluckメソッドを使います。
    # pluckメソッドは、引数で指定したカラムを配列で返すメソッドです。
    got_reaction_user_ids = Reaction.where(to_user_id: current_user.id, status: "like").pluck(:from_user_id)
    # mapメソッドは、要素の数だけ繰り返しブロックを実行し、ブロックの戻り値を集めた配列を作成して返します。
    # Reaction.where(to_user_id: got_reaction_user_ids, from_user_id:current_user.id, status:"like").map{|reaction| reaction.to_user}
    # 以下の3つの条件を満たせば、ブロックの代わりに&:メソッド名という引数で渡せます
    # - ブロックの引数が1つである。- ブロックの中で呼び出すメソッドには引数がない。- ブロックの中では、ブロック引数に対してメソッドを1個呼び出す以外の処理がない。
    @match_users = Reaction.where(to_user_id: got_reaction_user_ids, from_user_id: current_user.id, status: "like").map(&:to_user)
    @user = User.find(current_user.id)
  end
end
