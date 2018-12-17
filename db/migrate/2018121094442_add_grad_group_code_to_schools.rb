class AddGradGroupCodeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :grad_group_code, :string
  end
end
