class Article < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :player_id, presence: true
  validates :content, presence: true
end
