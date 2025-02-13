class AddUserIdToAdmins < ActiveRecord::Migration[7.2]
  def change
    add_column :admins, :user_id, :integer
  end
end
