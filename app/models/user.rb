class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_articles, dependent: :destroy

  has_many :active_relationships, class_name: "Relationships",
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :current_password

  # 8~32文字内で半角英数字が1つ以上含まれている
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX },
    on: :update, allow_blank: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :user_name, presence: true, uniqueness: true
  validates :profile, length: { maximum: 500 }

  mount_uploader :image, ImageUploader

  def update_without_current_password(params, *options)
    # edit機能を使うためにユーザーのパスワードを入力するというdeviseの使用を変更するため
    params.delete(:current_password)

    # パスワード、確認パスワードが両方入力されているときのみ更新できるようにするため
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
