class CheckoutController < ApplicationController
  before_action :set_amount
  def index
    @location = Location.new
  end

  def payment
    if request.post?
      # ActiveMerchant accepts all amounts as Integer values in cents
      ActiveMerchant::Billing::Base.mode = :test

      gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password'
      )

      #amount = 1000  # $10.00
      credit_card = ActiveMerchant::Billing::CreditCard.new(
        :first_name         => "Abhishek",
        :last_name          => 'Singh',
        :number             => params[:number],
        :month              => params[:expiry_date][0..1],
        :year               => 2000 + params[:expiry_date][3..4].to_i,
        :verification_value => params[:cvv] # The card verification value is also known as CVV2, CVC2, or CID
      )
    end
    # Validating the card automatically detects the card type
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(@amount * 100, credit_card)

      if response.success?
        #puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
        current_user.orders.each do |order|
          order.destroy
        end
        redirect_to successfull_payment_path, notice: "Successfully charged $#{sprintf("%.2f", @amount)} to the credit card #{credit_card.display_number}"
      else
        #raise StandardError, response.message
        redirect_to checkout_path, alert: "Transaction was unsuccessful!"
      end
    else
      redirect_to checkout_path, alert: 'Enter valid card details'
    end
  end

  private
  def set_amount
    @amount = 0
    current_user.orders.each do |order|
      @amount += order.quantity * Product.find(order.product_id).price
    end
  end
end
