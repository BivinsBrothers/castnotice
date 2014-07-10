class SendCritiqueNotification
  include Interactor

  def perform
    CritiqueRequestNotification.new.async.perform(critique)
  end
end