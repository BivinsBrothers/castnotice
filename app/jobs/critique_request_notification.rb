class CritiqueRequestNotification
  include SuckerPunch::Job

  def perform(critique)
    Notifier.critique_request(critique).deliver
  end
end