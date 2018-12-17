class ChangeLocationIdToGradProgramCode < ActiveRecord::Migration
  def change
    rename_column :sittings,    :location_id, :grad_program_code
    rename_column :demo_videos, :location_id, :grad_program_code

    Sitting.connection.schema_cache.clear!
    Sitting.reset_column_information

    DemoVideo.connection.schema_cache.clear!
    DemoVideo.reset_column_information

    change_column :sittings,    :grad_program_code, :string, null: true
    change_column :demo_videos, :grad_program_code, :string, null: true

    drop_table :locations
  end
end
