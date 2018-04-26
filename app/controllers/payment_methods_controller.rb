class PaymentMethodsController < ApplicationController
  def create
    if request.xhr?
      pm = PaymentMethod.new( create_new_payment_method_params )

      if pm.save
        render partial: "success_msg", layout: false, locals: { pm: pm }
      end
    end
  end

    private

      def create_new_payment_method_params
        params.require( :payment_method ).permit( :user_id, :cnum, :cem, :cey, :ccvv )
      end
end
