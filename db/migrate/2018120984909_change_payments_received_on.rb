class ChangePaymentsReceivedOn < ActiveRecord::Migration
  def up
    change_column :payments, :received_on, :datetime

    Payment.all.each do |payment|
      payment.received_on = payment.created_at
      payment.save
    end
  end

  def down
    change_column :payments, :received_on, :date
  end
end
