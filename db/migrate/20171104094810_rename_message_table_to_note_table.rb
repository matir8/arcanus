class RenameMessageTableToNoteTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :messages, :notes
  end
end
