class SendCritiqueNotification
  include Interactor

  def perform
    Notifier.critique_request(critique).deliver
  end
end