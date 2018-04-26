class PaymentMethod < ApplicationRecord
  belongs_to :user

  def mask
    self.cnum.gsub( /(?!.{1,4}$)./, "*" )
  end
end
