class Users::Mailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    @user_name = record.user_name
    # customize
    super
  end

  def reset_password_instructions(record, token, opts={})
    @user_name = record.user_name
    # customize
    super
  end
end
