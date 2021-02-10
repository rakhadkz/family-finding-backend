class SendgridController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :valid_webhook_token?
  
  def webhook
  end

  private

  def valid_webhook_token?
    params[:token] == ENV["SENDGRID_WEBHOOK_TOKEN"]
  end
end