class SettingsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(settings_params)
      redirect_to edit_settings_path, notice: 'Settings were successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def settings_params
    params.require(:user).permit(:email, :password)
  end
end