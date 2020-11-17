class Api::V1::Admin::SearchVectorsController < ApplicationController
    include Filterable
    include Searchable
    include Sortable
  
    before_action :authenticate_request!
    before_action :require_admin
    before_action :set_search_vector, only: [:show, :update, :destroy]
    
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
  
    def update
      @search_vector.update!(search_vector_params)
      render json: SearchVectorBlueprint.render(@search_vector, root: :data)
    end
  
    def destroy
      @search_vector.destroy!
      render status: :ok
    end
  
    private
      def set_search_vector
        @search_vector = SearchVector.find(params[:id])
      end
  
      def search_vector_params
        params.require(:search_vector).permit(:name, :description, :in_continuous_search)
      end
  
    def search_vector_scope
        SearchVector.all
    end
  end
  