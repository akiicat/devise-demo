class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_redirect('devise.github_uid', 'Github')
  end

  def facebook
    handle_redirect('devise.facebook_data', 'Facebook')
  end

  def failure
    redirect_to '/'
  end

  private

  def handle_redirect(_session_variable, kind)
    @user = User.from_omniauth(auth_hash)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      @user.save
      session[_session_variable] = auth_hash
      redirect_to new_user_registration_url
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
