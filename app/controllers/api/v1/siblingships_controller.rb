class Api::V1::SiblingshipsController < ApplicationController

  before_action :authenticate_request!
  before_action :set_siblingship, only: [:show, :destroy]
  before_action :set_view, only: [:show]

  def index
    siblingships = Siblingship.all
    render json: SiblingshipBlueprint.render(siblingships, root: :data)
  end

  def show
    render json: SiblingshipBlueprint.render(@siblingship, view: @view, root: :data)
  end

  def create
    siblingship = Siblingship.create!(siblingship_params)
    render json: SiblingshipBlueprint.render(siblingship, root: :data)
  end

  def destroy
    @siblingship.destroy!
    head :ok
  end

  private

  def set_siblingship
    @siblingship = Siblingship.includes(:child, :sibling).find(params[:id])
  end

  def siblingship_params
    params
        .require(:siblingship)
        .permit([
                    :child_id,
                    :sibling_id
                ])
  end

end
