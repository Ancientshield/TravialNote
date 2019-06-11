class CreateDiaryTags < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_tags do |t|
      t.integer :diary_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
