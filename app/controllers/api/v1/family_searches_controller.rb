class Api::V1::FamilySearchesController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: FamilySearchBlueprint.render(family_search_scopes, root: :data)
  end

  def show
    render json: FamilySearchBlueprint.render(family_search, root: :data)
  end

  def create
    family_search = FamilySearch.create!(family_search_params)
    render json: FamilySearchBlueprint.render(family_search, root: :data)
  end

  def update
    family_search.update!(family_search_params)
    render json: FamilySearchBlueprint.render(family_search, root: :data)
  end

  def destroy
    family_search.destroy!
    head :ok
  end

  private
  def family_search_scopes
    FamilySearch.order(created_at: :asc)
  end

  def family_search
    @family_search ||= FamilySearch.find(params[:id])
  end

  def family_search_params
    params.require(:family_search).permit(:search_vector_id, :user_id, :child_id, :description, :blocks)
  end
end
