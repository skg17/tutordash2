class UsersController < ApplicationController
    # Uses the cleaner auth layout for login/signup pages
    layout "auth", only: [ :new, :create ]
    # Skip authentication requirement for signup pages
    skip_before_action :require_user, only: [ :new, :create ]

    # GET /signup
    def new
      @user = User.new
      # Renders the signup form (users/new.html.erb)
    end

    # POST /users
    # app/controllers/users_controller.rb

    def create
        unless params[:user][:sign_up_key].present? && params[:user][:sign_up_key] == ENV["SIGNUP_KEY"]
            flash.now[:alert] = "The provided sign-up key is invalid."

            # Build resource to retain entered values for re-rendering, excluding the secure key
            @user = User.new(user_params.except(:sign_up_key))
            render :new, status: :unprocessable_entity and return
        end

        @user = User.new(user_params.except(:sign_up_key))

        if @user.save
            # Auto-login after successful signup
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Account created successfully! Welcome to TutorDash."
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def user_params
      # Must permit the sign_up_key from the form
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :sign_up_key)
    end
end
