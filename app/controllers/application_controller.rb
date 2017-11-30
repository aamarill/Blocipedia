class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # Per Devise documentation. This line needs to come AFTER "protect_from_forgery"
    # before_action :authenticate_user!

    private

    def require_sign_in
        unless current_user
            flash[:alert] = "You must be logged in to do that"

            redirect_to new_user_registration_path
        end
    end
end
