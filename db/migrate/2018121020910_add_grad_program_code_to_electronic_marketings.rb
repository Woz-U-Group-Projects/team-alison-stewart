class AddGradProgramCodeToElectronicMarketings < ActiveRecord::Migration
  def change
    add_column :electronic_marketings, :grad_program_code, :string, :null => false
  end
end
