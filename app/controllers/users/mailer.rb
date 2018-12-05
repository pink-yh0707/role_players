class Users::Mailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    @name = record.name
    # customize
    super
  end

  def reset_password_instructions(record, token, opts={})
    @name = record.name
    # customize
    super
  end
end
