class UsersController < ApplicationController
    # Uses the cleaner auth layout for login/signup pages
    layout 'auth', only: [:new, :create] 
    # Skip authentication requirement for signup pages
    skip_before_action :require_user, only: [:new, :create]

    # GET /signup
    def new
      @user = User.new
      # Renders the signup form (users/new.html.erb)
    end

    # POST /users
    def create
      # Validate the sign-up key against the ENV variable
      unless params[:user][:sign_up_key].present? && params[:user][:sign_up_key] == ENV['SIGNUP_KEY']
          flash.now[:alert] = "The provided sign-up key is invalid."
          # Rebuilds the user object for rendering the form again
          @user = User.new(user_params.except(:sign_up_key)) 
          # Render :new with errors (using flash.now to show the message on the same request)
          render :new, status: :unprocessable_entity and return
      end

      # Proceed with user creation if key is valid.
      @user = User.new(user_params.except(:sign_up_key))

      if @user.save
          # Auto-login after successful signup
          session[:user_id] = @user.id
          redirect_to root_path, notice: "Account created successfully! Welcome to TutorDash."
      else
          # Failed signup: render form with errors
          render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      # Must permit the sign_up_key from the form
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :sign_up_key)
    end
end