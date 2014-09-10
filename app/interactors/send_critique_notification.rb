class SendCritiqueNotification
  include Interactor

  def call
    CritiqueRequestNotification.new.async.perform(context.critique)
  end
end
