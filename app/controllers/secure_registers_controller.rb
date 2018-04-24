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
    key = RegistrantKey.find_by( key: params[ :key ] )
    redirect_to unauthenticated_root_path( auth_msg: "Sorry, this token is already expired. Please try registering this user again!" ) if key.used
    names = key.full_name.split( " " )
    User.create( first_name: names[ 0 ], last_name: names[ 1 ], email: key.email, password: "ChangeMe123!", password_confirmation: "ChangeMe123!" )
    key.update_attributes( used: true )
    finish_key = SecureRandom.urlsafe_base64
    CompleteKey.create( full_name: key.full_name, email: key.email, key: finish_key )
    CompleteRegistrationMailer.complete_signup( key.full_name, key.email, finish_key ).deliver_now
    redirect_to unauthenticated_root_path( auth_msg: "The account has been confirmed. An email has been sent to the registrant with steps to login. Thank you!" )
  end

  def complete_signup
    key = CompleteKey.find_by( key: params[ :key ] )
    redirect_to unauthenticated_root_path( auth_msg: "Sorry this token is already expired. Please try logging in with your account credentials or reset your password." ) if key.used
    user = User.find_by( email: key.email )
    sign_in( user, scope: :user )
    redirect_to edit_user_path( user )
  end
end
