class AddStudentNameToIdCardRequests < ActiveRecord::Migration
  def change
    add_column :id_card_requests, :student_name, :string
  end
end
