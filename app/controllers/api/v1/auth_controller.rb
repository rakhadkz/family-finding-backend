class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_for_database_authentication(email: user_params[:email])
    if user&.valid_password?(user_params[:password])
      render json: UserBlueprint.render(user, view: :auth, root: :data)
    else
      raise ApiException::Unauthorized, 'Your login or password are incorrect'
    end
  end

  def signup
    user = User.create!(user_params)
    render json: UserBlueprint.render(user, view: :auth, root: :data)
  end

  def forgot_password
    user = User.find_by!(email: params[:email])
    user.send_reset_password_instructions
    head :ok
  end

  def reset_password
    token = params[:change_password_token]
    user = User.reset_password_by_token(
      reset_password_token: token,
      password: params[:password],
      password_confirmation: params[:password]
    )
    render json: UserBlueprint.render(user, root: :data)
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
  end
end
