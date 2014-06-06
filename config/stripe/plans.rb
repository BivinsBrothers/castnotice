Stripe.plan :monthly do |plan|
  plan.name = "Monthly Subscription"
  plan.amount = 799
  plan.interval = "month"
end
Stripe.plan :annual do |plan|
  plan.name = "Annual Subscription"
  plan.amount = 6999
  plan.interval = "year"
end
Stripe.plan :broadway do |plan|
  plan.name = "Broadway Breakthrough Annual Subscription"
  plan.amount = 5999
  plan.interval = "year"
end
