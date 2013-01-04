class RegistrationsController < Devise::RegistrationsController

  def resource_params
    params.require(:user).permit(:email, :password, :current_password)
  end
  private :resource_params

end
