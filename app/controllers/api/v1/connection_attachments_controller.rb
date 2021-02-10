class Api::V1::ConnectionAttachmentsController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: ConnectionAttachmentBlueprint.render(connection_attachments_scope, root: :data)
  end

  def show
    render json: ConnectionAttachmentBlueprint.render(connection_attachment, root: :data)
  end

  def create
    item = ChildContactAttachment.create!(connection_attachment_params)
    render json: ConnectionAttachmentBlueprint.render(item, root: :data)
  end

  def update
    connection_attachment.update!(connection_attachment_params)
    render json: ConnectionAttachmentBlueprint.render(connection_attachment, root: :data)
  end

  def destroy
    connection_attachment.destroy!
    head :ok
  end

  private
  def connection_attachments_scope
    ChildContactAttachment.where(child_contact_id: params[:child_contact_id])
  end

  def connection_attachment
    @connection_attachment ||= ChildContactAttachment.find(params[:id])
  end

  def connection_attachment_params
    params.require(:connection_attachment)
      .permit([
                :child_contact_id,
                :attachment_id
              ])
  end
end
