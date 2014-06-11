module Promo
  module Helpers
    def enter_promo_code
      case example.metadata[:type]
      when :feature
        visit page_path("promo")
        fill_in "Promo Code", with: "BreakThru2014"
        click_button "Register"
      when :controller
        session[:allow_breakthrough_promo] = true
      end
    end
  end
end
