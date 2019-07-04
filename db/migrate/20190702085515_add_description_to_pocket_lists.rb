class AddDescriptionToPocketLists < ActiveRecord::Migration[5.2]
  def change
    add_column :pocket_lists, :description, :string
  end
end
