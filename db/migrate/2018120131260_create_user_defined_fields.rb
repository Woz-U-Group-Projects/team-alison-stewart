class CreateUserDefinedFields < ActiveRecord::Migration
  def change
    create_table 'USER_DEF_FIELDS', { id: false } do |t|
      t.string :ROWID, primary: true
      t.string :DOCUMENT_ID

      t.string :ID
      t.string :STRING_VAL

      t.string  'UDF-0000014'
      t.string  'UDF-0000015'
      t.date    'UDF-0000017'
      t.boolean 'UDF-0000018'
      t.boolean 'UDF-0000019'
      t.boolean 'UDF-0000020'
      t.string  'UDF-0000021'
      t.string  'UDF-0000022'
      t.date    'UDF-0000023'
      t.string  'UDF-0000027'
      t.string  'UDF-0000029'
      t.string  'UDF-0000030'
      t.string  'UDF-0000173'
      t.integer 'UDF-0000177'
    end
  end
end
