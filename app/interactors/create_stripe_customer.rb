class CreateStripeCustomer
  include Interactor

  def perform
    begin
      customer = Stripe::Customer.create(
        card: context[:stripe_token],
        description: context[:user].id
      )
      context[:user].update_attributes(stripe_customer_id: customer.id)
      context[:customer] = customer
    rescue Stripe::StripeError => e
      context[:error] = e.message
      fail!
    end
  end

  def rollback
    context[:stripe_customer].delete
    context[:user].update_attributes(stripe_customer_id: nil)
  end
end
