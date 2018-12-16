class Article < ApplicationRecord
  belongs_to :user

  has_one :player_image
  accepts_nested_attributes_for :player_image

  has_one :player
  accepts_nested_attributes_for :player
  
  validates :user_id, presence: true
  validates :player_id, presence: true
  validates :content, presence: true
end
