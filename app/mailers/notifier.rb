class Notifier < ActionMailer::Base
  default from: "hello@castnotice.com"

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

  def reset_campers_password_instructions(user, token)
    @user = user
    @token = token
    email_to = user.under_18? ? user.parent_email : user.email
    mail to: email_to,
      subject: "Reset password instructions"
  end

  def invite_talent_mentors(email_to)
    @email = email_to
    mail to: email_to,
         subject: "We Want To Hire You"
  end

  def invite_campers(email_to, link_to_sign_up)
    @link_to_sign_up = link_to_sign_up
    mail to: email_to,
         from: "bbt@castnotice.com",
      subject: 'URGENT: BBT Summer Intensive Registration'
  end
end
