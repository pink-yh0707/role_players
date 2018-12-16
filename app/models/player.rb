class Player < ApplicationRecord
  belongs_to :player_image
  has_one :article
end
