class ChargesController < ApplicationController

  # Stripe.api_key = ""
  #
  # def payment
  #   token = params[:stripeToken]
  #   raise '2341231231'
  #   render :payment
  # end


  # Set your secret key: remember to change this to your live secret key in production
  # See your keys here: https://dashboard.stripe.com/account/apikeys
  def create


    Stripe.api_key = ""
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a charge: this will charge the user's card
    begin
      customer = Stripe::Customer.create(

      )

      charge = Stripe::Charge.create(
      :amount => 500, # Amount in cents
      :currency => "aud",
      :source => token,
      :description => "WDI Conf 2k16 - Ticket"
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end

    if charge.status == 'succeeded'
      redirect_to({
        controller: 'attendee',
        action: 'create' },
        'params[:first_name]' => params[:first_name],
        'params[:second_name]' => params[:second_name],
        'params[:email]' => params[:email],
        'params[:phone]' => params[:phone] )



    end
  end

end
