class Reaction < ApplicationRecord
  # class_nameモデル名を直接指定するオプションです。
  # リアクションは、リアクションした人(from_user)やリアクションされた人(to_user)に従属しているが実際のモデル名がUserである場合。
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  enum status: {like: 0, dislike: 1} 
end
