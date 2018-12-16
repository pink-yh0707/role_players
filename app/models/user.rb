class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :articles, dependent: :destroy

  attr_accessor :current_password

  # 8~32文字内で半角英数字が1つ以上含まれている
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :user_name, presence: true, uniqueness: true

  mount_uploader :image, ImageUploader

  def update_with_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
    end

    update_attributes(params, *options)
  end
end
