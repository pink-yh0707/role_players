class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :comment

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:article_id, :created_at]
  end
end
