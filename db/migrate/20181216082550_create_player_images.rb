class CreatePlayerImages < ActiveRecord::Migration[5.2]
  def change
    create_table :player_images do |t|
      t.integer :article_id
      t.integer :player_id
      t.string :image

      t.timestamps
    end
    add_index :player_images, [:id, :article_id], unique: true
    add_index :player_images, [:id, :player_id], unique: true
  end
end
