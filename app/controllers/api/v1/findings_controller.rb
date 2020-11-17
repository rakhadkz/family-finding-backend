class Api::V1::FindingsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_finding, only: [:show, :update, :destroy]
  before_action :set_view, only: [:show]

  def show
    render json: FindingBlueprint.render(@finding, view: @view, root: :data)
  end

  def create
    @finding = Finding.create!(finding_params)
    render json: FindingBlueprint.render(@finding, root: :data)
  end

  def update
    @finding.update!(finding_params)
    render json: FindingBlueprint.render(@finding, root: :data)
  end

  def destroy
    @finding.destroy!
    render status: :ok
  end

  private
  def finding_params
    params
        .require(:finding)
        .permit([
                    :child_id,
                    :search_vector_id,
                    :user_id,
                    :description
                ])
  end

  def set_finding
    @finding = Finding.includes(:attachments, :user, :child, :search_vector).find(params[:id])
  end

end
