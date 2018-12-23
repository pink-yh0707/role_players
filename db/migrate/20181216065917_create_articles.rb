class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :player_id
      t.text :content

      t.timestamps
    end
    add_index :articles, [:id, :user_id], unique: true
    add_index :articles, [:id, :player_id], unique: true
  end
end
