class Api::V1::TwilioPhoneNumbersController < ApplicationController  
    before_action :authenticate_request!

    def index
      render json: TwilioPhoneNumberBlueprint.render(organization_phone_number, root: :data)
    end

    private

    def organization_phone_number
       @organization_phone_number ||= TwilioPhoneNumber.where(organization_id: @current_user.organization_id).first
    end
  end
  