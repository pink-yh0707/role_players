class PlayerImage < ApplicationRecord
  belongs_to :article
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
end
