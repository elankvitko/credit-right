class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    user = User.find( params[ :id ] )
    redirect_to unauthenticated_root_path if current_user != user
    @msg = current_user.sign_in_count == 1 ? "Welcome" : "Edit Your Info"
  end

  def update
    if current_user.update_attributes( update_params )
      bypass_sign_in current_user
      redirect_to dashboard_path
    end
  end

    private

      def update_params
        params.require( :user ).permit( :first_name, :last_name, :email, :address, :address_second, :city, :state, :zip, :po, :password, :password_confirmation )
      end
end
