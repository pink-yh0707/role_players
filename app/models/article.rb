class Article < ApplicationRecord
  belongs_to :user

  has_one :player, dependent: :destroy
  accepts_nested_attributes_for :player, update_only: true

  has_many :comments

  has_many :favorite_articles, dependent: :destroy
  has_many :favorites, through: :favorite_articles, source: :user

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :article_title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 10000 }

  mount_uploader :article_image, ArticleImageUploader

  enum status: { privated: 0, released: 1 }

  private
    def self.search(search)
      if search
        where(["player_name LIKE (:search) OR team_name LIKE (:search)", search: "%#{search}%"])
      else
        all
      end
    end

    def self.favorite_sort
      select("articles.*", "COUNT(favorite_articles.id) AS favs")
      .left_joins(:favorite_articles).group("articles.id").unscope(:order).order("favs DESC")
    end

    def self.my_favorite_articles_sort
      left_joins(:favorite_articles).group("favorite_articles.id")
      .unscope(:order).order("favorite_articles.created_at desc")
    end
end
