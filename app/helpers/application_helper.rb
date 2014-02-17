module ApplicationHelper
  def us_states_select
    states = []
    Country['US'].states.each do |state|
      states << [state[1]["name"], state[1]["name"]]
    end
    states
  end
end
