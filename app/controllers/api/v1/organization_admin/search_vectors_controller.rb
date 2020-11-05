class Api::V1::OrganizationAdmin::SearchVectorsController < ApplicationController
    include Filterable
    include Searchable
    include Sortable
  
    before_action :authenticate_request!
    before_action :require_organization_admin
    before_action :set_search_vector, only: [:show, :update, :destroy]
  
    # GET /search_vector
  
    def index
      results = sort(search(filter(search_vector_scope)))
      search_vector = results.page(params[:page]).per(per_page)
      render json: SearchVectorBlueprint.render(search_vector, root: :data, meta: page_info(search_vector))
    end
  
    def show
      render json: SearchVectorBlueprint.render(@search_vector, root: :data)
    end
  
    def create
        search_vector = SearchVector.create!(search_vector_params)
        render json: SearchVectorBlueprint.render(search_vector, root: :data)
    end
  
    # PATCH/PUT /search_vector/1
    def update
      if @search_vector.update(search_vector_params)
        render json: SearchVectorBlueprint.render(@search_vector, root: :data)
      else
        render json: @search_vector.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /search_vector/1
    def destroy
      @search_vector.destroy
      render status: :ok
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_search_vector
        @search_vector = SearchVector.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def search_vector_params
        params.require(:search_vector).permit(:name, :description, :in_continuous_search)
      end
  
    def search_vector_scope
        SearchVector.all
    end
  end
  