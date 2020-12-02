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
    params[:user][:phone] = TwilioPhone.format(user_params)
    user = User.create!(user_params)
    params[:organizations].map do |organization|
      user.user_organizations.create!(organization_id: organization[:id], role: organization[:role])
    end if params[:organizations]
    user.send_reset_password_instructions
    render json: UserBlueprint.render(user, view: :auth, root: :data)
  end

  def forgot_password
    user = User.find_by!(email: params[:email])
    user.send_reset_password_instructions
    render json: UserBlueprint.render(user, root: :data)
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
        :first_name,
        :last_name,
        :email,
        :phone,
        :role,
        :password,
        :password_confirmation
      )
  end
end
