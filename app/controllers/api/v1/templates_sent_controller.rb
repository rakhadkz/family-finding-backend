class Api::V1::TemplatesSentController < ApplicationController
    before_action :authenticate_request!
  
    def index
      render json: TemplatesSentBlueprint.render(communication_templates_scope, root: :data)
    end

    private

    def communication_templates_scope
      TemplatesSent.filter_by_contact_id(@current_user.organization_id)
    end
  end
  