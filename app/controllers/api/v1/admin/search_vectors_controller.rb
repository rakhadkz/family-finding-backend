class Api::V1::Admin::SearchVectorsController < ApplicationController

    before_action :authenticate_request!
    before_action :require_admin
    
    def index
      search_vectors = SearchVector.all
      render json: SearchVectorBlueprint.render(search_vectors, root: :data)
    end
  
    def show
      render json: SearchVectorBlueprint.render(search_vector, root: :data)
    end
  
    def create
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
  
    private
      def search_vector
        @search_vector ||= SearchVector.find(params[:id])
      end
  
      def search_vector_params
        params.require(:search_vector).permit(:name, :description, :in_continuous_search)
      end
  end
  