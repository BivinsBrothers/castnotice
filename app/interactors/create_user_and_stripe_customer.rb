class CreateUserAndStripeCustomer
  include Interactor::Organizer

  organize CreateUser, CreateStripeCustomer, SelectRegistrationPlan
end
