class Api::V1::SchoolDistrictsController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: SchoolDistrictBlueprint.render(SchoolDistrict.all, root: :data)
  end
end
