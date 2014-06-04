module StripePlanConstraint
  def self.matches?(request)
    return true unless request.path_parameters.key?(:stripe_plan)
    request.path_parameters.key?(:stripe_plan) &&
      Stripe::Plans.all.map { |plan| plan.id.to_s }.include?(request.path_parameters[:stripe_plan])
  end
end
