class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  around_action :measure_time, only: [:create, :update, :destroy]

  def index
    #index method is used to display all the items
    @items = Item.all
  end

  def show
    #it is used to get the single item
  end

  def new
    #this is used to give the form for the items
    @item = Item.new
  end

  def create
    #this is used to create the items provided fields
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    #this is used to get the item form with params
  end

  #this is used to update the item based upon the attributes
  def update
    if @item.update(item_params)
      redirect_to items_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def process_payment
    stripe_service = StripeService.new

    # Here, we expect to get the stripe token from the front end
    token = params[:stripeToken] 

    # Find or create a customer for the user
    stripe_customer = stripe_service.find_or_create_customer(current_user)

    begin
      # Charge the customer using the token and the item price
      charge = stripe_service.stripe_charge(@item.id, stripe_customer.id, token)

      # After the successful payment, you can redirect or show a success message
      redirect_to item_path(@item), notice: "Payment Successful!"
    rescue Stripe::CardError => e
      # Handle errors if payment fails
      flash[:error] = e.message
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def measure_time
    start_time = Time.now
    yield  # Executes the action (i.e., create, update, or destroy)
    end_time = Time.now
    # Ensure the log output is correctly formatted
    Rails.logger.info("Time taken for the action: #{(end_time - start_time).round(4)} seconds")
  end

 
end
