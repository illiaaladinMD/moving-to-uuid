class AddColumnsForUuidFk < ActiveRecord::Migration[7.0]
  TABLES_WITH_FK = {
    posts: [:user_uuid],
    reactions: [:user_uuid, :post_uuid],
    followings: [:following_uuid, :follower_uuid]
  }

  def up
    TABLES_WITH_FK.each do |table, fk_names|
      fk_names.each do |fk_name|
        add_column table, fk_name, :uuid
      end
    end
  end

  def down
    TABLES_WITH_FK.each do |table, fk_names|
      fk_names.each do |fk_name|
        remove_column table, fk_name
      end
    end
  end
end
