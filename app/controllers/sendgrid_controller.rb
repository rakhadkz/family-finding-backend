require 'uri'
require 'net/http'

class SendgridController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :valid_webhook_token?, raise: false
  before_action :set_template, only: :webhook
 
  def webhook
    @template.update_column(:opened, sendgrid_params[:event])

    render json: {}, status: :ok
  end

  def authenticate_domain
    authenticate_domain_res = authenticate_domain_name(domain_params[:name])
    puts('wWSSSSSws',authenticate_domain_res,'wsd')
    # choose_phone_number = TwilioPhone.choose_phone_number(params[:phone])
    # add_phone = TwilioPhone.add_phone_number(choose_phone_number.sid)
    # created = TwilioPhoneNumber.create!(
    #   phone: params[:phone],
    #   friendly_name: params[:friendly_name],
    #   phone_sid: choose_phone_number.sid,
    #   organization_id: params[:organization_id]
    # )
    render json: authenticate_domain_res, status: :ok
  end

  private

  def domain_params
    params.require(:domain).permit(:name)
  end

  def set_template
    @template = TemplatesSent.find_by(id: sendgrid_params[:ff_msg_id])
  end

  def sendgrid_params
    params.require(:_json).first.permit(:ff_msg_id, :event)
  end

  def authenticate_domain_name(domain_name)
    url = URI("https://api.sendgrid.com/v3/whitelabel/domains")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    puts domain_name
    
    request = Net::HTTP::Post.new(url)
    request["authorization"] = 'Bearer ' + ENV["SENDGRID_API_KEY"]
    request["content-type"] = 'application/json'
    request.body = '{ "domain": "' + domain_name + '"}'
    
    response = http.request(request)
    response.read_body
  end

  def valid_webhook_token?
    params[:token] == ENV["SENDGRID_WEBHOOK_TOKEN"]
  end
end