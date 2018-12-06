class RenameNameColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :name, :user_name
  end
end
