class SelectRegistrationPlan
  include Interactor

  def perform
    begin
      plan = customer.subscriptions.create(:plan => stripe_plan)
      context[:plan] = plan
      user.update_attributes(stripe_plan_id: plan.id)
    rescue Stripe::StripeError => e
      fail!(error: e.message)
    end
  end

  def rollback
    user.update_attributes(stripe_customer_id: nil)
  end

end
