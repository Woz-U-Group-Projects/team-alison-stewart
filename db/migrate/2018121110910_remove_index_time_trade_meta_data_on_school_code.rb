class RemoveIndexTimeTradeMetaDataOnSchoolCode < ActiveRecord::Migration
  def change
    remove_index :time_trade_meta_data, :school_code
  end
end
