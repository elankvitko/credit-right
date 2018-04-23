class SecureRegistersController < ApplicationController
  def push_out
    name = params[ :user ][ :name ]
    email = params[ :user ][ :email ]
    key = SecureRandom.urlsafe_base64
    RegistrantKey.create( full_name: name, email: email, key: key )
    SecureRegistersMailer.new_register_request( name, email, key ).deliver_now
    redirect_to unauthenticated_root_path
  end

  def accept_new_registrant
    binding.pry
  end
end
