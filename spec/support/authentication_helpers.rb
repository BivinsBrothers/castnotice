module Authentication
  module Helpers
    def log_in(user)
      password = user.password || "goodpassword"

      case example.metadata[:type]
      when :feature
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: password
        click_button "Sign in"
      end
    end
  end
end