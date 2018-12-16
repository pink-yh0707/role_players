class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :player_name
      t.string :team_name
      t.string :country
      t.integer :height
      t.integer :weight
      t.string :position

      t.timestamps
    end
  end
end
