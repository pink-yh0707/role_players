class Article < ApplicationRecord
  belongs_to :user

  has_one :player, dependent: :destroy
  accepts_nested_attributes_for :player, update_only: true

  has_many :comments

  has_many :favorite_articles, dependent: :destroy
  has_many :favorites, through: "favorite_articles", source: "user"

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :article_title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 10000 }

  mount_uploader :article_image, ArticleImageUploader

  enum status: { privated: 0, released: 1 }

  def self.search(search)
    if search
      where(["player_name LIKE (:search) OR team_name LIKE (:search)", search: "%#{search}%"])
    else
      all
    end
  end
end
