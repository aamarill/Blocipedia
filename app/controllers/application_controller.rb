class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # Per Devise documentation. This line needs to come AFTER "protect_from_forgery"
    before_action :authenticate_user!

end
