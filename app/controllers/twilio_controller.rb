class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :valid_webhook_token?, raise: false
  before_action :set_template

  def webhook
    @template.update_column(:opened, params[:SmsStatus])
    render json: {}, status: :ok
  end

  def available_phone_numbers
    available_phone_numbers = TwilioPhone.available_phone_numbers
    data = { data: available_phone_numbers }
    render json: data, status: :ok
  end

  def choose_phone_number
    choose_phone_number = TwilioPhone.choose_phone_number(params[:phone])
    add_phone = TwilioPhone.add_phone_number(choose_phone_number.sid)
    created = TwilioPhoneNumber.create!(
      phone: params[:phone],
      friendly_name: params[:friendly_name],
      phone_sid: choose_phone_number.sid,
      organization_id: params[:organization_id]
    )
    render json: created, status: :ok
  end

  private

  def set_template
    @template = TemplatesSent.find_by(sid: params[:SmsSid])
  end

  def valid_webhook_token?
    params[:token] == ENV["TWILIO_WEBHOOK_TOKEN"]
  end
end