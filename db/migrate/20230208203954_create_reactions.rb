class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.timestamps
    end

    add_reference :reactions, :post, foreign_key: true
    add_reference :reactions, :user, foreign_key: true
  end
end
