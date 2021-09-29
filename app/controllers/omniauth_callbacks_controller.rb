class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    # if @user.persisted?
    #   flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
    #   sign_in_and_redirect @user, event: :authentication
    # else
    #   session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
    #   redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    # end

    if @user.persisted?
      sign_in @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
    end
    redirect_to '/'

  end

  def failure
    redirect_to root_path
  end
end
