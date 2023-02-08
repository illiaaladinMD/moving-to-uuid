class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false

      t.timestamps
    end
  end
end
