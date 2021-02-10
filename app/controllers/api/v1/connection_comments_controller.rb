class Api::V1::ConnectionCommentsController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: ConnectionCommentBlueprint.render(connection_comments_scope, root: :data)
  end

  def show
    render json: ConnectionCommentBlueprint.render(connection_comment, root: :data)
  end

  def create
    item = ChildContactComment.create!(connection_comment_params)
    render json: ConnectionCommentBlueprint.render(item, root: :data)
  end

  def update
    connection_comment.update!(connection_comment_params)
    render json: ConnectionCommentBlueprint.render(connection_comment, root: :data)
  end

  def destroy
    connection_comment.destroy!
    head :ok
  end

  private
  def connection_comments_scope
    ChildContactComment.where(child_contact_id: params[:child_contact_id])
  end

  def connection_comment
    @connection_comment ||= ChildContactComment.find(params[:id])
  end

  def connection_comment_params
    params.require(:connection_comment)
      .permit([
                :child_contact_id,
                :comment_id
              ])
  end
end
