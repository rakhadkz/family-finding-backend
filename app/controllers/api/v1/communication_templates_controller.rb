class Api::V1::CommunicationTemplatesController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: CommunicationTemplateBlueprint.render(communication_templates_scope, root: :data)
  end

  def show
    render json: CommunicationTemplateBlueprint.render(communication_template, root: :data)
  end

  def create
    communication_template = CommunicationTemplate.create!(communication_template_params.merge({organization_id: @current_user.organization_id}))
    render json: CommunicationTemplateBlueprint.render(communication_template, root: :data)
  end

  def update
    communication_template.update(communication_templates_scope)
    render json: CommunicationTemplateBlueprint.render(communication_template, root: :data)
  end

  def destroy
    communication_template.destroy!
    head :ok
  end

  private

  def communication_template
    @communication_template ||= communication_templates_scope.find(params[:id])
  end

  def communication_templates_scope
    CommunicationTemplate.filter_by_organization_id(@current_user.organization_id)
  end

  def communication_template_params
    params.require(:communication_template)
      .permit(
        [
          :name,
          :content,
          :template_type
        ]
      )
  end



end
