class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.integer :follower_id, null: false
      t.integer :following_id, null: false

      t.timestamps
    end

    add_foreign_key :followings, :users, column: :follower_id
    add_foreign_key :followings, :users, column: :following_id
  end
end
