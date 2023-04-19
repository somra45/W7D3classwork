class UsersController < ApplicationController

    # before_action :require_logged_in, only: [:create]
    def new
        @user = User.new

        render :new
    end

    def index
        @users = User.all

        render :index
    end

    def show
        @user = User.find_by(id: params[:id])

        render :show
    end

    def create
        @user = User.new(user_params)

        if @user.save
            @user.reset_session_token!
            session[:session_token] = @user.session_token
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_user_url
        end
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
