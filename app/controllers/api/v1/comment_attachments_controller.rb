class Api::V1::ChildAttachmentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_comment_attachment, only: [:show, :destroy]
  before_action :set_view, only: [:show]

  def index
    comment_attachments = CommentAttachment.all
    render json: CommentAttachmentBlueprint.render(comment_attachments, root: :data)
  end

  def show
    render json: CommentAttachmentBlueprint.render(@comment_attachment, view: @view, root: :data)
  end

  def create
    comment_attachment = CommentAttachment.create!(child_attachment_params)
    render json: CommentAttachmentBlueprint.render(comment_attachment, view: @view, root: :data)
  end

  def update
    comment_attachment = CommentAttachment.update!(child_attachment_params)
    render json: CommentAttachmentBlueprint.render(comment_attachment, view: @view, root: :data)
  end

  def destroy
    @comment_attachment.destroy
    head :ok
  end

  private
  def set_comment_attachment
    @comment_attachment = CommentAttachment.includes(:attachment).find(params[:id])
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
