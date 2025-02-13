require 'stripe'
class StripeService
  def initialize() #it works as the constructor method in ruby 
    Stripe.api_key=ENV['Secret_key']
  end

  def find_or_create_customer(customer)
    if customer.stripe_customer_id.present?
      stripe_customer=Stripe::Customer.retrieve(customer.stripe_customer_id)
    else
      stripe_customer=Stripe::Customer.create({
        email:customer.email
      })
      customer.update(stripe_customer_id:stripe_customer.id)
    end
    stripe_customer
  end
end