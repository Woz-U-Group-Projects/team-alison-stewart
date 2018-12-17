ActiveAdmin.register GatewayTransaction do
  menu parent: 'Manage Bookings'

  actions :index, :show

  filter :success
  filter :reference

  index do
    column 'Payment' do |gt|
      link_to gt.payment.uuid, admin_payment_path(gt.payment) if gt.payment
    end
    column(:amount) { |gt| number_to_currency gt.amount_in_dollars }
    column(:action)
    column(:success)
    column(:message)
    column(:reference)
    actions
  end

  show do
    attributes_table do
      row :id
      row(:payment) do
        link_to gateway_transaction.payment.uuid, admin_payment_path(gateway_transaction.payment) if gateway_transaction.payment
      end
      row(:amount) { |gt| number_to_currency gt.amount_in_dollars }
      row(:action)
      row(:success)
      row(:reference)
      row(:message)
      row(:response)
      row(:created_at)
      row(:updated_at)
    end
  end
end
