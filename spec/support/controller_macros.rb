module ControllerMacros
  def login(user)
    # routes.rb内のdevise_forをマッピングしsign_inを使用可能にする
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end
