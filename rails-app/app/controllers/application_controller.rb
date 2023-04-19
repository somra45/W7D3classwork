class ApplicationController < ActionController::Base

    helper_method :logged_in?, :current_user

    def current_user
        @current_user = User.find_by(session_token: session[:session_token])
        @current_user
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end

    def logout!
        session[:session_token] = nil
        user.reset_session_token!
        redirect_to users_url # usually we want this to be new_session url as that is our login page
    end

    # def require_logged_in
    #     if !logged_in?
    #         redirect_to new_session_url
    #     end
    # end

    # def require_logged_out
    #     if logged_in?
    #         logout!
    #     end
    # end
end
