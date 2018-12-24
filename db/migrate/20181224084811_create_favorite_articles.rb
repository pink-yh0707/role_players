class CreateFavoriteArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_articles do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
    add_index :favorite_articles, [:user_id, :id]
    add_index :favorite_articles, [:article_id, :id]
    add_index :favorite_articles, [:user_id, :article_id], unique: true
  end
end
