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
    template_sent = TemplatesSent.create!(
      communication_template_id: template_send_params[:template_id],
      child_contact_id: template_send_params[:child_contact_id],
      content: template_send_params[:content],
    )
    msg = template_sent[:id];
    email = template_send_params[:email];
    content = template_send_params[:content]
    case template_send_params[:template_type]
      when 'SMS'
        twilioPhoneResult = TwilioPhoneNumber.where(organization_id: @current_user.organization_id).first || { phone: '+13238706031' }
        sid = TwilioPhone.send(template_send_params, twilioPhoneResult[:phone])
        template_sent.update_column(:sid, sid)
      when 'Email'
        UserMailer.send_message_to_contact(msg,content,email).deliver_now
    end
    data = { data: template_sent }
    render json: data;
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
          :from_phone,
          :contact_id,
          :template_id,
          :child_id,
          :child_contact_id
        ]
      )
  end
end
