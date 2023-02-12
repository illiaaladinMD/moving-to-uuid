class AddUuidToAllTables < ActiveRecord::Migration[7.0]
  TABLES = [:users, :posts, :reactions, :followings]
  
  def up
    TABLES.each do |table|
      add_column table, :uuid, :uuid, default: "gen_random_uuid()", null: false
      add_index table, :uuid, unique: true
    end
  end

  def down
    TABLES.each do |table|
      remove_column table, :uuid
    end
  end
end
