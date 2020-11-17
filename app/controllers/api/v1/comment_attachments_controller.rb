class Api::V1::CommentAttachmentsController < ApplicationController
  before_action :authenticate_request!

  def index
    comment_attachments = CommentAttachment.all
    render json: CommentAttachmentBlueprint.render(comment_attachments, root: :data)
  end

  def show
    render json: CommentAttachmentBlueprint.render(comment_attachment, view: view, root: :data)
  end

  def create
    comment_attachment = CommentAttachment.create!(child_attachment_params)
    render json: CommentAttachmentBlueprint.render(comment_attachment, root: :data)
  end

  def update
    comment_attachment.update!(child_attachment_params)
    render json: CommentAttachmentBlueprint.render(comment_attachment, root: :data)
  end

  def destroy
    comment_attachment.destroy!
    head :ok
  end

  private
  def comment_attachment
    @comment_attachment ||= CommentAttachment.includes(:attachment).find(params[:id])
  end

  def comment_attachment_params
    params
        .require(:comment_attachment)
        .permit([
                    :comment_id,
                    :attachment_id
                ])
  end
end
