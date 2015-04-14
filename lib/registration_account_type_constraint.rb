module RegistrationAccountTypeConstraint
  def self.matches?(request)
    non_stripe_registration_types = %w( mentor new_admin )
    return true unless request.path_parameters.key?(:account_type)
    request.path_parameters.key?(:account_type) &&
      Stripe::Plans.all.map { |plan| plan.id.to_s }.concat(non_stripe_registration_types).include?(request.path_parameters[:account_type])
  end
end
