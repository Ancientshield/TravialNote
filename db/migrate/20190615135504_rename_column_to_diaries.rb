class RenameColumnToDiaries < ActiveRecord::Migration[5.2]
  def change
    rename_column :diaries, :is_editing, :is_published
    change_column_default :diaries, :is_published, default: false
  end
end
