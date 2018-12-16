class AddArticleTitleToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :article_title, :string
  end
end
