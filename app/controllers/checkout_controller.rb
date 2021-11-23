class CheckoutController < ApplicationController

  def index
    @location = Location.new
    @order_price = User.find(current_user.id).orders.length
  end

  def payment
    if request.post?
      # ActiveMerchant accepts all amounts as Integer values in cents
      ActiveMerchant::Billing::Base.mode = :test

      gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password'
      )

      amount = 1000  # $10.00
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
    #puts "*****************************#{credit_card.validate}"
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(amount, credit_card)

      if response.success?
        #puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
        redirect_to successfull_payment_path, notice: "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        #raise StandardError, response.message
        redirect_to checkout_path, alert:'Enter valid card details'
      end
    else
      redirect_to checkout_path, alert: 'Improper Card details format'
    end
  end
end
