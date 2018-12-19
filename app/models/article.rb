class Article < ApplicationRecord
  belongs_to :user

  has_one :player_image
  accepts_nested_attributes_for :player_image, update_only: true

  has_one :player
  accepts_nested_attributes_for :player, update_only: true

  validates :user_id, presence: true
  validates :article_title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 10000 }
end
