class Player < ApplicationRecord
  belongs_to :article

  validates :player_name, presence: true, length: { maximum: 50 }
  validates :team_name,   presence: true, length: { maximum: 50 }
  validates :country,     presence: true, length: { maximum: 30 }
  validates :height,      presence: true, length: { maximum: 20 }
  validates :weight,      presence: true, length: { maximum: 20 }
  validates :position,    presence: true, length: { maximum: 20 }
end
