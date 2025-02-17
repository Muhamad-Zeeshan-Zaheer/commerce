require 'stripe'

class StripeService
  def initialize
    Stripe.api_key = ENV['Secret_key']
  end

  def find_or_create_customer(customer)
    if customer.stripe_customer_id.present?
      stripe_customer = Stripe::Customer.retrieve(customer.stripe_customer_id)
    else
      stripe_customer = Stripe::Customer.create(email: customer.email)
      customer.update(stripe_customer_id: stripe_customer.id)
    end
    stripe_customer
  end
  def stripe_charge(item_id, stripe_customer_id, card_id)
    item = Item.find(item_id) 
    amount = (item.price * 10
    Stripe::Charge.create({
      amount: amount,
      currency: 'usd',
      source: card_id,
      customer: stripe_customer_id
    })
  end
end
