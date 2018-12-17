class MakeFeaturesPolymorphic < ActiveRecord::Migration
  def change
    add_column :features, :owner_id,    :integer
    add_column :features, :owner_type,  :string

    Feature.connection.schema_cache.clear!
    Feature.reset_column_information

    Feature.all.each do |feature|
      feature.owner_type = 'Sitting'
      feature.owner_id = feature.sitting_id
      feature.save
    end

    remove_column :features, :sitting_id
  end
end
