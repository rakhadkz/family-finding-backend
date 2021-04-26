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
    created = SendgridDomain.create!(
      domain_id: authenticate_domain_res["id"],
      organization_id: domain_params[:organization_id]
    )
    render json: authenticate_domain_res, status: :ok
  end

  private

  def domain_params
    params.require(:domain).permit(:name,:organization_id)
  end

  def set_template
    @template = TemplatesSent.find_by(id: sendgrid_params[:ff_msg_id])
  end

  def sendgrid_params
    params.require(:_json).first.permit!
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
    JSON.parse(response.body)
  end

  def valid_webhook_token?
    params[:token] == ENV["SENDGRID_WEBHOOK_TOKEN"]
  end
end