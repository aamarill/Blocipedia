class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    super
    redirect_to new_user_registration_path
  end

  def update
    super
    flash[:notice] = "Password was updated."
  end

end
