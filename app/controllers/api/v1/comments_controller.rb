class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: CommentBlueprint.render(comment, view: view, root: :data)
  end

  def create
    comment = @current_user.comments.create!(comment_params)
    render json: CommentBlueprint.render(comment, root: :data)
  end

  def update
    comment.update!(comment_params)
    render json: CommentBlueprint.render(comment, root: :data)
  end

  def destroy
    comment.destroy!
    head :ok
  end

  private

  def comment
    @comment ||= Comment.includes(:attachments, :parent, :replies, :user).find(params[:id])
  end

  def comment_params
    params.require(:comment)
      .permit(
        [
          :title,
          :body,
          :in_reply_to,
          :child_id
        ])
  end
end
