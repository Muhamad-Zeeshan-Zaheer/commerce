class AddColourToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :colour, :string
  end
end
