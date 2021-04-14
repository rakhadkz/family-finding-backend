class Api::V1::Admin::SearchVectorsController < ApplicationController
  require 'net/https'
  before_action :authenticate_request!
  before_action :require_admin
  include Filterable
  include Searchable
  include Sortable

  def index
    results = sort(search(filter(search_vector_scope)))
    search_vectors = results.page(params[:page]).per(per_page)
    render json: SearchVectorBlueprint.render(search_vectors, root: :data, view: view, meta: page_info(search_vectors))
  end

  def show
    render json: SearchVectorBlueprint.render(search_vector, root: :data)
  end

  def create
    params[:search_vector][:organization_id] = @current_user.organization_id
    search_vector = SearchVector.create!(search_vector_params)
    render json: SearchVectorBlueprint.render(search_vector, root: :data)
  end

  def update
    search_vector.update!(search_vector_params)
    render json: SearchVectorBlueprint.render(search_vector, root: :data)
  end

  def destroy
    search_vector.destroy!
    render status: :ok
  end

  def send_request

    render json: { result: "Hello" }
  end

  private
    def search_vector_scope
      SearchVector.filter_by_org_id @current_user.organization_id
    end

    def search_vector
      @search_vector ||= SearchVector.find(params[:id])
    end

    def search_vector_params
      params.require(:search_vector).permit(:name, :description, :in_continuous_search, :organization_id, :task_id)
    end
end
  