class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: UserBlueprint.render(@current_user, view: view, root: :data)
  end

  def update
    @current_user.update!(user_params)
    render json: UserBlueprint.render(@user, root: :data)
  end

  def destroy
    @current_user.destroy!
    head :ok
  end

  def user_params
    params
      .require(:user)
      .permit([
        :email,
        :role,
        :first_name,
        :last_name,
        :phone
      ])
  end

end
