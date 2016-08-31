class ContactMailer < ApplicationMailer

  def contact_mailer(name, email, phone, prefered_contact, inquiry)
    @name = name
    @email = email
    @phone = phone
    @prefered_contact = prefered_contact
    @inquiry = inquiry
    mail(to: "outloudrock@gmail.com", subject: "Website Inquiry: #{@name}")
  end
end
