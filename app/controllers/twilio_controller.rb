class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :valid_webhook_token?, raise: false
  before_action :set_template

  def webhook
    @template.update_column(:opened, params[:SmsStatus])
    render json: {}, status: :ok
  end

  private

  def set_template
    @template = TemplatesSent.find_by(sid: params[:SmsSid])
  end

  def valid_webhook_token?
    params[:token] == ENV["TWILIO_WEBHOOK_TOKEN"]
  end
end