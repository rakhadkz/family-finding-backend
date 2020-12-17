class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: CommentBlueprint.render(comment, view: view, root: :data)
  end

  def create
    comment = @current_user.comments.create!(comment_params)
    sendMentionEmails(comment)
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

  def sendMentionEmails(comment)
    UserMailer.comment_reply(comment).deliver_later unless comment.in_reply_to.blank? || comment.child_id.blank? || comment.in_reply_to==0
    UserMailer.comment_mentions(comment) if comment.mentions.present?
    if(comment.in_reply_to.present?)
      replied_comment = Comment.find_by_id(comment.in_reply_to)
      ActionItem.create!(
        user_id: replied_comment.user_id, 
        child_id: comment.child_id, 
        description: comment.body,
        title: "New Comment"
      ) unless replied_comment.user_id == @current_user.id
    end
    if comment.mentions.present?
      comment.mentions.each do |id|
        ActionItem.create!(
          user_id: id, 
          child_id: comment.child_id, 
          description: comment.body,
          title: "New Comment"
        ) 
      end
    end
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
          :child_id,
          :mentions => []
        ])
  end
end
