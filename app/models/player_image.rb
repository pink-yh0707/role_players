class PlayerImage < ApplicationRecord
  has_one :article
  has_one :player
end
