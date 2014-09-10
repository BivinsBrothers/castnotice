class CreateCritiqueStripeCharge
  include Interactor

  def call
    context.user.eligible_for_free_critique? ? free_critique : paid_critique
  end

  # there is no rollback because this interactor represents the end of the
  # transaction for our purposes. If this interactor is ever followed in the
  # organizer by a interactor that can invoke "#fail!", then we need to
  # implement rollback

  private

  def free_critique
    context.critique.payment_method = "breakthru_free"
    context.critique.save
    return
  end

  def paid_critique
    begin
      charge = Stripe::Charge.create(
        amount: 2500,
        currency: "usd",
        customer: context.user.stripe_customer.id,
        description: "CastNotice Critique",
        metadata: {
          user_id: context.user.id
        }
      )
      context.critique.payment_method = "stripe"
      context.critique.stripe_charge_id = charge.id
      context.critique.save
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end
  end
end
