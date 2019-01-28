class ChangeDatatypeHeightOfPlayers < ActiveRecord::Migration[5.2]
  def change
    change_column :players, :height, :string
    change_column :players, :weight, :string
  end
end
