class RemoveColourFromItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :items, :color, :string
  end
end
