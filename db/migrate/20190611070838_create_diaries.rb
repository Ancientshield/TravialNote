class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.datetime :diary_date
      t.integer :user_id
      t.text :content
      t.json :location
      t.boolean :is_editing, default:true

      t.timestamps
    end
  end
end
