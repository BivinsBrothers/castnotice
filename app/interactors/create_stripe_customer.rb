class CreateStripeCustomer
  include Interactor

  def perform
    begin
      customer = Stripe::Customer.create(
        card: stripe_token,
        description: user.id
      )
      user.update_attributes(stripe_customer_id: customer.id)
      context[:customer] = customer
    rescue Stripe::StripeError => e
      fail!(error: e.message)
    end
  end

  def rollback
    customer.delete
    user.update_attributes(stripe_customer_id: nil)
  end
end
