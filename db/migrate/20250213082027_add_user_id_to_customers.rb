class AddUserIdToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :user_id, :integer
  end
end
