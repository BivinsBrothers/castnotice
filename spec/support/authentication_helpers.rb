module Authentication
  module Helpers
    def log_in(user)
      password = user.password || "goodpassword"

      case example.metadata[:type]
      when :request
        Warden.test_mode!
        login_as(user, :scope => :user)
      when :feature
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: password
        click_button "Sign in"
      when :controller
        sign_in user
      end
    end
  end
end