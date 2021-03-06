class SecureRegistersMailer < ApplicationMailer
  def new_register_request( name, email, key )
    @name = name
    @email = email
    @key = key

    mail to: "elan.kvitko@gmail.com",
         from: "Credit Right <no-reply@credit-right.com>",
         subject: "#{ name } - Request for Account Approval!"
  end
end
