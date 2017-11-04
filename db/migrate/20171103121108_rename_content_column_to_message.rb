class RenameContentColumnToMessage < ActiveRecord::Migration[5.1]
  def change
    rename_column :messages, :content, :message
  end
end
