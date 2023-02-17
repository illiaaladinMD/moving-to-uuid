class MoveToUuidInAllTables < ActiveRecord::Migration[7.0]
  TABLES_WITH_RELATIONS = {
    users: {
      posts: {user_id: :user_uuid},
      reactions: {user_id: :user_uuid},
      followings: {following_id: :following_uuid, follower_id: :follower_uuid}
    },
    posts: {
      reactions: {post_id: :post_uuid}
    }
  }

  def up
    TABLES_WITH_RELATIONS.each do |table, related_tables|
      # remove relations
      remove_foreign_keys(related_tables)

      # migrate to UUID PKs
      rename_column table, :id, :numeric_id
      rename_column table, :uuid, :id
      change_pk(table)

      # migrate to UUID FKs
      related_tables.each do |related_table, fks|
        fks.each do |fk_name, uuid_fk_name|
          numeric_fk_name = "numeric_#{fk_name}".to_sym
          change_column_null related_table, fk_name, true
          rename_column related_table, fk_name, numeric_fk_name
          rename_column related_table, uuid_fk_name, fk_name
          add_foreign_key related_table, table, column: fk_name
        end
      end
    end
  end

  def down
    TABLES_WITH_RELATIONS.each do |table, related_tables|
      # remove relations
      remove_foreign_keys(related_tables)

      # rollback to numeric PKs
      rename_column table, :id, :uuid
      rename_column table, :numeric_id, :id
      change_pk(table)

      # rollback to numeric FKs
      related_tables.each do |related_table, fks|
        fks.each do |fk_name, uuid_fk_name|
          numeric_fk_name = "numeric_#{fk_name}".to_sym
          rename_column related_table, fk_name, uuid_fk_name
          rename_column related_table, numeric_fk_name, fk_name
          add_foreign_key related_table, table, column: fk_name
          change_column_null related_table, fk_name, false
        end
      end
    end
  end

  def remove_foreign_keys(tables)
    tables.each do |table, fks|
      fks.each_key do |fk_name|
        remove_foreign_key table, column: fk_name
      end
    end
  end

  def change_pk(table)
    execute "ALTER TABLE #{table} DROP CONSTRAINT #{table}_pkey;"
    execute "ALTER TABLE #{table} ADD PRIMARY KEY (id);"
  end
end
