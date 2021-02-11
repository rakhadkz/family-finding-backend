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
    communication_template.update!(communication_template_params)
    render json: CommunicationTemplateBlueprint.render(communication_template, root: :data)
  end

  def destroy
    communication_template.destroy!
    head :ok
  end

  def send_message_to_contact
    TemplatesSent.create!(
      contact_id: template_send_params[:contact_id], 
      communication_template_id: template_send_params[:template_id],
      content: template_send_params[:content],
      child_id: template_send_params[:child_id]
    )
    case template_send_params[:template_type]
    when 'SMS'
      TwilioPhone.send(template_send_params)
    when 'Email'
      UserMailer.send_message_to_contact(template_send_params[:email],template_send_params[:content]).deliver_now
    end
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
          :name,
          :content,
          :template_type
      )
  end
  def template_send_params
    params.require(:template_send)
      .permit(
        [
          :email,
          :content,
          :template_type,
          :phone,
          :contact_id,
          :template_id,
          :child_id
        ]
      )
  end
end
