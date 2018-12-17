class CreateIdCardReplacementRequests < ActiveRecord::Migration
  def change
    create_table :id_card_replacement_requests do |t|
      t.string  :request_type
      t.string  :passcode
      t.string  :school
      t.string  :attention_of
      t.string  :attention_of_email
      t.string  :student_fname
      t.string  :student_lname
      t.string  :student_homeroom
      t.string  :student_grade
      t.string  :student_number
      t.string  :id_barcode
      t.text    :reason_for_reprint

      t.timestamps
    end
  end
end
