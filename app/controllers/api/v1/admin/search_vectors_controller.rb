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
    first_name = params[:contact][:first_name]
    last_name = params[:contact][:last_name]
    uri = URI("https://www.bop.gov/PublicInfo/execute/inmateloc?todo=query&output=json&nameFirst=" + first_name + "&nameLast=" + last_name)
    render json: Net::HTTP.get(uri)
  end

  private
    def search_vector_scope
      SearchVector.filter_by_org_id @current_user.organization_id
    end

    def search_vector
      @search_vector ||= SearchVector.find(params[:id])
    end

    def search_vector_params
      params.require(:search_vector).permit(:name, :description, :in_continuous_search, :organization_id)
    end
end
  