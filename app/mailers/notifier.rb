class Notifier < ActionMailer::Base
  default from: "support@castnotice.com"

  def contact_us(from_name, from_email, subject, content)
    @from_name = from_name
    @from_email = from_email
    @content = content
    mail :to => Figaro.env.castnotice_admin_email,
         :subject => subject
  end

  def critique_request(critique)
    @critique = critique
    mail :to => Figaro.env.castnotice_admin_email,
         :subject => "Critique Request"
  end

  def critique_response(critique)
    @critique = critique
    mail :to => Figaro.env.castnotice_admin_email,
         :subject => "Critique Response"
  end

  def critique_complete(critique)
    @critique = critique
    mail :to => critique.user.email,
         :subject => "Critique Complete"
  end
end
