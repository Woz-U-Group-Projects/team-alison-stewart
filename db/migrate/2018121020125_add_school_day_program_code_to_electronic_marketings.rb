class AddSchoolDayProgramCodeToElectronicMarketings < ActiveRecord::Migration
  def change
    add_column :electronic_marketings, :school_day_program_code, :string
  end
end
