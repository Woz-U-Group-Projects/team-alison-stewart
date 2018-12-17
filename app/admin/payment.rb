ActiveAdmin.register Payment do
  menu parent: 'Manage Bookings'

  actions :index, :show

  filter :uuid
  filter :gateway_transaction_reference, as: :string
  filter :payment_method
  filter :received_on

  scope :all, default: true

  index do
    column 'Customer Booking' do |p|
      link_to p.booking.customer_id, admin_booking_path(p.booking)
    end
    column(:amount) { |p| number_to_currency p.amount_in_dollars }
    column :payment_method
    column 'Gateway Transaction Reference' do |p|
      link_to p.gateway_transaction.reference, admin_gateway_transaction_path(p.gateway_transaction)
    end
    column :received_on
    actions
  end

  show do
    attributes_table do
      row :id
      row(:uuid)
      row 'Customer Booking' do |p|
        link_to p.booking.customer_id, admin_booking_path(p.booking)
      end
      row(:amount) { |i| number_to_currency i.amount_in_dollars }
      row(:payment_method)
      row 'Gateway Transaction Reference' do |p|
        link_to p.gateway_transaction.reference, admin_gateway_transaction_path(p.gateway_transaction)
      end
      row(:gateway_transaction)
      row(:received_on)
      row(:created_at)
      row(:updated_at)
    end
  end
end
