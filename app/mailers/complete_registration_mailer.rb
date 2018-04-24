class CompleteRegistrationMailer < ApplicationMailer
  def complete_signup( name, email, key )
    @name = name
    @key = key

    mail to: email,
         from: "Credit Right <no-reply@credit-right.com>",
         subject: "#{ name } - Your Account is Ready!"
  end
end
