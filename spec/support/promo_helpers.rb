module Promo
  module Helpers
    def enter_promo_code
      case RSpec.current_example.metadata[:type]
      when :feature
        visit page_path("promo")
        fill_in "Promo Code", with: "BreakThru2014"
        click_button "Register"
      when :controller
        session[:promo_code] = "BreakThru2014"
      end
    end
  end
end
