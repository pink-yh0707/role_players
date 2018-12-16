class Article < ApplicationRecord
  belongs_to :user
  belongs_to :player_image
  belongs_to :player
  validates :user_id, presence: true
  validates :player_id, presence: true
  validates :content, presence: true
end
