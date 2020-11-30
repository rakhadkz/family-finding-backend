class Api::V1::FindingAttachmentsController < ApplicationController
  before_action :authenticate_request!

  def index
    finding_attachments = FindingAttachment.all
    render json: FindingAttachmentBlueprint.render(finding_attachments, root: :data)
  end

  def show
    render json: FindingAttachmentBlueprint.render(finding_attachment, view: view, root: :data)
  end

  def create
    finding_attachment = FindingAttachment.create!(finding_attachment_params)
    render json: FindingAttachmentBlueprint.render(finding_attachment, root: :data)
  end

  def update
    finding_attachment.update!(finding_attachment_params)
    render json: FindingAttachmentBlueprint.render(finding_attachment, root: :data)
  end

  def destroy
    finding_attachment.destroy!
    head :ok
  end

  private

  def finding_attachment
    @finding_attachment ||= FindingAttachment.includes(:attachment).find(params[:id])
  end

  def finding_attachment_params
    params.require(:finding_attachment)
      .permit([
        :finding_id,
        :attachment_id
      ])
  end

end
