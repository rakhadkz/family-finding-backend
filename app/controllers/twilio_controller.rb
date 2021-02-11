class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :valid_webhook_token?, raise: false
  
  def webhook
    puts params
  end

  private

  def valid_webhook_token?
    params[:token] == ENV["TWILIO_WEBHOOK_TOKEN"]
  end
end