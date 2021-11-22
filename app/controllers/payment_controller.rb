class PaymentController < ApplicationController

  def index
    if request.post?
      # ActiveMerchant accepts all amounts as Integer values in cents
      ActiveMerchant::Billing::Base.mode = :test

      gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password'
      )

      amount = 1000  # $10.00
      credit_card = ActiveMerchant::Billing::CreditCard.new(
        :first_name         => 'Tobias',
        :last_name          => 'Luetke',
        :number             => '4242424242424242',
        :month              => '8',
        :year               => Time.now.year+1,
        :verification_value => '000' # The card verification value is also known as CVV2, CVC2, or CID
      )
    end
    # Validating the card automatically detects the card type
    #byebug
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(amount, credit_card)

      if response.success?
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        raise StandardError, response.message
      end
    end
  end
end
