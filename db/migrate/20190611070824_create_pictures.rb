class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.integer :diary_id
      t.json :pic_url

      t.timestamps
    end
  end
end
