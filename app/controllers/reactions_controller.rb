class ReactionsController < ApplicationController
  def create
    # find_or_create_byと同様に動作しますが、createの代りにnewを呼ぶ点が異なります。
    # つまり、モデルの新しいインスタンスは作成されますが、その時点ではデータベースに保存されていません。
    reaction = Reaction.find_or_initialize_by(to_user_id: params[:user_id], from_user_id: current_user.id)
    # update_attributesは引数に渡した情報を更新できるメソッドです。
    # 今回の場合、reactionというインスタンスに対して、statusを更新し保存しています。
    reaction.update_attributes(
      status: params[:reaction]
    )
  end
end
