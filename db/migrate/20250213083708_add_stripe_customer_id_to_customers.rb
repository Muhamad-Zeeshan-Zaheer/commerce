class AddStripeCustomerIdToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :stripe_customer_id, :string
  end
end
