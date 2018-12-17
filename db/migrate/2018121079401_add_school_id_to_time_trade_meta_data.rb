class AddSchoolIdToTimeTradeMetaData < ActiveRecord::Migration
  def change
    add_reference :time_trade_meta_data, :school, index: true, foreign_key: true
  end
end
