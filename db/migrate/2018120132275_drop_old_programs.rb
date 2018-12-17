class DropOldPrograms < ActiveRecord::Migration
  def change
    drop_table :programs

    remove_column :event_types, :program_id
    add_column :event_types, :program_slug, :string
  end
end
