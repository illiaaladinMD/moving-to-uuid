class ChangePkInTablesWithBelongsToRelationsOnly < ActiveRecord::Migration[7.0]
  TABLES = [:followings, :reactions]

  def up
    TABLES.each do |table|
      rename_column table, :id, :numeric_id
      rename_column table, :uuid, :id
      change_pk(table)
    end
  end

  def down
    TABLES.each do |table|
      rename_column table, :id, :uuid
      rename_column table, :numeric_id, :id
      change_pk(table)
    end
  end

  def change_pk(table)
    execute "ALTER TABLE #{table} DROP CONSTRAINT #{table}_pkey;"
    execute "ALTER TABLE #{table} ADD PRIMARY KEY (id);"
  end
end
