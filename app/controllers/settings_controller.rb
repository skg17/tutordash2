class SettingsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(settings_params)
      redirect_to edit_settings_path, notice: "Settings were successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def disconnect_google
    google_account = current_user.user_accounts.find_by(provider: "google_oauth2")

    if google_account
      google_account.destroy
      redirect_to edit_settings_path, notice: "Successfully disconnected your Google account."
    else
      redirect_to edit_settings_path, alert: "Could not find a Google account to disconnect."
    end
  end

  private

  def settings_params
    params.require(:user).permit(:email, :password)
  end
end
