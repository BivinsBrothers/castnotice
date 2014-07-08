class RequestCritique
  include Interactor::Organizer

  organize [
    CreateCritique,
    CreateCritiqueStripeCharge,
    SendCritiqueNotification
  ]
end