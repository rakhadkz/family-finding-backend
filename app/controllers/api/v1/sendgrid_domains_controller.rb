require 'uri'
require 'net/http'

class Api::V1::SendgridDomainsController < ApplicationController  
    before_action :authenticate_request!

    def index
      data = {data: organization_domain }
      render json: data
    end

    private

    def organization_domain
        organization_first ||= SendgridDomain.where(organization_id: @current_user.organization_id).first
        url = URI("https://api.sendgrid.com/v3/whitelabel/domains/" + organization_first.domain_id.to_s)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(url)
        request["authorization"] = 'Bearer ' + ENV["SENDGRID_API_KEY"]
        response = http.request(request)
        @organization_domain ||= JSON.parse(response.body)
    end
  end
  