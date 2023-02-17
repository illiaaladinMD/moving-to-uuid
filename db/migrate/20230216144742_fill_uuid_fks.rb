class FillUuidFks < ActiveRecord::Migration[7.0]
  ENTITIES_WITH_RELATIONS = {
    {model: Post, table: :posts} => {User => [:user_id]},
    {model: Reaction, table: :reactions} => {User => [:user_id], Post => [:post_id]},
    {model: Following, table: :followings} => {User => [:following_id, :follower_id]},
  }

  def up
    ENTITIES_WITH_RELATIONS.each do |entity, related_models|
      entity[:model].all.each do |record|
        related_models.each do |related_model, fks|
          fks.each do |fk_name|
            numeric_fk_name = "numeric_#{fk_name}".to_sym
            record[fk_name] = related_model.find_by(numeric_id: record[numeric_fk_name]).id
          end
        end
        record.save!
      end
      related_models.each_value do |fks|
        fks.each do |fk_name|
          change_column_null entity[:table], fk_name, false
        end
      end
    end
  end

  def down
    ENTITIES_WITH_RELATIONS.each do |entity, related_models|
      entity[:model].all.each do |record|
        related_models.each do |related_model, fks|
          fks.each do |fk_name|
            numeric_fk_name = "numeric_#{fk_name}".to_sym
            record[numeric_fk_name] = related_model.find_by(id: record[fk_name]).numeric_id
          end
        end
        record.save!
      end
      related_models.each_value do |fks|
        fks.each do |fk_name|
          change_column_null entity[:table], fk_name, true
        end
      end
    end
  end
end
