class SessionsController < ApplicationController
  # Uses the cleaner auth layout for login/signup pages
  layout 'auth', only: [:new, :create] 
  # Skip authentication requirement for accessing the login form or submitting it
  skip_before_action :require_user, only: [:new, :create]

  # GET /login
  def new
    # Renders the login form
  end

  # POST /login
  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      # Successful login: store user ID in the session hash
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{user.name || user.email.split('@').first}!"
    else
      # Failed login: display error
      flash.now[:alert] = "Invalid email or password combination."
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  def destroy
    # Log user out by clearing the session
    session[:user_id] = nil
    redirect_to login_path, notice: "You have been logged out."
  end
end
