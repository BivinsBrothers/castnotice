class CreateStripeCustomer
  include Interactor

  def call
    begin
      customer = Stripe::Customer.create(
        card: context.stripe_token,
        description: context.user.id
      )
      context.customer = customer
      context.user.update_attributes(stripe_customer_id: context.customer.id)
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end
  end

  def rollback
    context.user.update_attributes(stripe_customer_id: nil)
  end
end
