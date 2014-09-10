class SelectRegistrationPlan
  include Interactor

  def call
    begin
      plan = context.customer.subscriptions.create(plan: context.stripe_plan)
      context.plan = plan
      context.user.update_attributes(stripe_plan_id: context.plan.id)
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end
  end

  def rollback
    context.user.update_attributes(stripe_customer_id: nil)
  end

end
