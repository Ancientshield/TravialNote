class CreatePocketLists < ActiveRecord::Migration[5.2]
  def change
    create_table :pocket_lists do |t|
      t.datetime :expect_date
      t.json :location
      t.integer :user_id

      t.timestamps
    end
  end
end
