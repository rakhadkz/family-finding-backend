class SendgridController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :valid_webhook_token?, raise: false
  before_action :set_template
 
  def webhook
    @template.update_column(:opened, sendgrid_params[:event])

    render json: {}, status: :ok
  end

  private

  def set_template
    @template = TemplatesSent.find_by(id: sendgrid_params[:ff_msg_id])
  end

  def sendgrid_params
    params.require(:_json).first.permit(:ff_msg_id, :event)
  end

  def valid_webhook_token?
    params[:token] == ENV["SENDGRID_WEBHOOK_TOKEN"]
  end
end