class AddStudentNumberToIdCardRequests < ActiveRecord::Migration
  def change
    add_column :id_card_requests, :student_number, :string
  end
end
