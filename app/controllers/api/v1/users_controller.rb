class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: UserBlueprint.render(@current_user, root: :data)
  end

end
