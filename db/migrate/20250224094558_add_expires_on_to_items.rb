class AddExpiresOnToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :expires_on, :date
  end
end
