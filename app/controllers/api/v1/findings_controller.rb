class Api::V1::FindingsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_finding, only: [:show, :update, :destroy]
  before_action :set_view, only: [:show]

  def create
    @finding = Finding.new(finding_params)

    if @finding.save
      render json: FindingBlueprint.render(@finding, root: :data), status: :created
    else
      render json: @finding.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: FindingBlueprint.render(@finding, view: @view, root: :data), status: :ok
  end

  def update
    if @finding.update(finding_params)
      render json: FindingBlueprint.render(@finding, root: :data), status: :ok
    else
      render json: @finding.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @child.destroy
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
    @finding = Finding.find(params[:id])
  end

end
