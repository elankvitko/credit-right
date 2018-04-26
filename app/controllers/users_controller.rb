class UsersController < ApplicationController
  before_action :authenticate_user!
  around_action :catch_not_found

  def edit
    user = User.find( params[ :id ] )

    if current_user != user
      redirect_to unauthenticated_root_path
    else
      if current_user.sign_in_count > 1
        redirect_to user_path( current_user )
      end
    end

    @msg = current_user.sign_in_count == 1 ? "Welcome" : "Edit Your Info"
  end

  def update
    if current_user.update_attributes( update_params )
      bypass_sign_in current_user
      redirect_to dashboard_path
    end
  end

  def show
    @pm = PaymentMethod.new
    @cards = current_user.payment_methods
  end

    private

      def update_params
        params.require( :user ).permit( :first_name, :last_name, :email, :address, :address_second, :city, :state, :zip, :po, :password, :password_confirmation )
      end
end
