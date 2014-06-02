class CreateStripeCustomer
  include Interactor

  def perform
    begin
      customer = Stripe::Customer.create(
        card: stripe_token,
        description: user.id
      )
      context[:customer] = customer
      user.update_attributes(stripe_customer_id: customer.id)
    rescue Stripe::StripeError => e
      fail!(error: e.message)
    end
  end

  def rollback
    user.update_attributes(stripe_customer_id: nil)
  end
end
