class Api::V1::ResourcesController < ApplicationController
    before_action :authenticate_request!
  
    def index
      render json: ResourceBlueprint.render(resource_scope, root: :data)
    end
  
    def show
      render json: ResourceBlueprint.render(resource, root: :data)
    end
  
    def create
      resource = Resource.create!(resource_params.merge({organization_id: @current_user.organization_id}))
      render json:ResourceBlueprint.render(resource, root: :data)
    end
  
    def update
      resource.update!(resource_params)
      render json: ResourceBlueprint.render(resource, root: :data)
    end
  
    def destroy
      resource.destroy!
      head :ok
    end
  
    def resource_scope
        Resource.filter_by_organization_id(@current_user.organization_id)
    end

    def resource
        @resource ||= resource_scope.find(params[:id])
    end
  
    def resource_params
      params.require(:resource)
        .permit(
            :name,
            :link,
        )
    end
  end
  