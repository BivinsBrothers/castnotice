class UserDecorator < Draper::Decorator
  delegate_all

  def stripe_plan
    if object.stripe_plan_id
      stripe_customer.subscriptions.retrieve(object.stripe_plan_id)
    end
  end

  def stripe_customer
    if object.stripe_customer_id
      Stripe::Customer.retrieve(object.stripe_customer_id)
    end
  end
end
