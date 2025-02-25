class StripeService
  def initialize
    Stripe.api_key = ENV['Secret_key']  # Use your secret key
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

  def stripe_charge(item_id, stripe_customer_id, token)
    item = Item.find(item_id)
    amount = (item.price * 100).to_i # Stripe expects amount in cents

    Stripe::Charge.create({
      amount: amount,
      currency: 'usd',
      source: token,
      customer: stripe_customer_id
    })
  end
end
