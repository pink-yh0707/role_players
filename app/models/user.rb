class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_articles, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :current_password

  # 8~32文字内で半角英数字が1つ以上含まれている
  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i, allow_blank: true
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
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

  def self.find_for_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.uid       = auth.uid
      user.provider  = auth.provider
      user.email     = User.dammy_email(auth)
      user.user_name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      # メール認証をスキップ
      user.skip_confirmation!
    end
  end

  def self.dammy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
