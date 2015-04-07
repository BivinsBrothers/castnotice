class CreateStripeMembership
  include Interactor::Organizer

  organize CreateStripeCustomer, SelectRegistrationPlan
end
