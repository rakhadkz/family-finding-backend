class Api::V1::CommentsController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :set_comment, only: [:show]
  before_action :my_comment, only: [:update, :destroy]

  def show
    render json: CommentBlueprint.render(comments, root: :data)
  end

  def create
    comment = @current_user.comments.create!(comment_params)
    render json: CommentBlueprint.render(comment, root: :data)
  end

  def update
    @my_comment.update!(comment_params)
    render json: SearchVectorBlueprint.render(@my_comment, root: :data)
  end

  def destroy
    @my_comment.destroy
    render status: :ok
  end

  private

  def comment_scope
    Comment.all
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def my_comment
    @my_comment = @current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment)
        .permit([
                    :title,
                    :body,
                    :in_reply_to
                ])
  end

end
