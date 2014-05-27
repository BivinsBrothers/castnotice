require "stripe/tasks"

Stripe.api_key = Figaro.env.stripe_secret_key
