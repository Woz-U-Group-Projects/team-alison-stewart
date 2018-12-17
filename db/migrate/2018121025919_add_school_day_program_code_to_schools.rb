class AddSchoolDayProgramCodeToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :school_day_program_code, :string
  end
end
