class RemovePlayerIdFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :player_id, :integer
  end
end
