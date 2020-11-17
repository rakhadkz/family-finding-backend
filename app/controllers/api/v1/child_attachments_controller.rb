class Api::V1::ChildAttachmentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_child_attachment, only: [:show, :destroy]
  before_action :set_view, only: [:show]

  def index
    child_attachments = ChildAttachment.all
    render json: ChildAttachmentBlueprint.render(child_attachments, root: :data)
  end

  def show
    render json: ChildAttachmentBlueprint.render(@child_attachment, view: @view, root: :data)
  end

  def create
    child_attachment = ChildAttachment.create!(child_attachment_params)
    render json: ChildAttachmentBlueprint.render(child_attachment, root: :data)
  end

  def update
    child_attachment = ChildAttachment.update!(child_attachment_params)
    render json: ChildAttachmentBlueprint.render(child_attachment, root: :data)
  end

  def destroy
    @child_attachment.destroy!
    head :ok
  end

  private

  def set_child_attachment
    @child_attachment = ChildAttachment.includes(:attachment).find(params[:id])
  end

  def child_attachment_params
    params
        .require(:child_attachment)
        .permit([
                    :child_id,
                    :attachment_id
                ])
  end
end
