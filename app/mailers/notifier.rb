class Notifier < ActionMailer::Base
  default from: "support@castnotice.com"

  def contact_us(from_name, from_email, subject, content)
    @from_name = from_name
    @from_email = from_email
    @content = content
    mail :to => "david@castnotice.com",
         :subject => subject
  end
end
