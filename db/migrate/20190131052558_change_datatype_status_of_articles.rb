class ChangeDatatypeStatusOfArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :status, :integer, default: 0
  end
end
