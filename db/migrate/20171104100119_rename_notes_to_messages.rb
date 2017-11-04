class RenameNotesToMessages < ActiveRecord::Migration[5.1]
  def change
    rename_table :notes, :messages    
  end
end
