class CreateReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reactions do |t|
      # references型は、_idを省略してカラムを作成してくれます。
      # to_user_idやfrom_user_idはusersテーブルのidを参照します。
      # こういった場合、参照先テーブル名を指定して、外部キー制約のコードを書きます。
      t.references :to_user, null: false, foreign_key: {to_table: :users}
      t.references :from_user, null: false, foreign_key: {to_table: :users}
      t.integer :status, null: false
      t.timestamps
    end
  end
end
