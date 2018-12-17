class AddGradProgramCodeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :grad_program_code, :string
  end
end
