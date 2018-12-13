class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :current_password

  # 8~32文字内で半角英数字が1つ以上含まれている
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :user_name, presence: true, uniqueness: true

  mount_uploader :image, ImageUploader

    def update_without_current_password(params, *options)
      # edit機能を使うためにユーザーのパスワードを入力するというdeviseの使用を変更するため
      params.delete(current_password)

      # パスワード、確認パスワードが両方入力されているときのみ更新できるようにするため
      if params[:password].blank? && params[:password_confirmation].blank?
        params[:password].delete
        params[:password_confirmation].delete
      end

      result = update_attributes(params, *options)
      clean_up_passwords
      result
    end
end
