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
    @user = User.new(user_params)

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
    # Ensure all required fields are permitted
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
