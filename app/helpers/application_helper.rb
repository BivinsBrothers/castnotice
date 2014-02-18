module ApplicationHelper
  def us_states_select
    Country['US'].states.map do |abbr, names|
      [names["name"], abbr]
    end
  end
end
