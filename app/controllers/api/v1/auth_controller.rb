class Api::V1::AuthController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid
  before_action :twilio_client, only: [:signup]

  def login
    user = User.find_for_database_authentication(email: user_params[:email])
    if user&.valid_password?(user_params[:password])
      render json: UserBlueprint.render(user, view: :auth, root: :data)
    else
      raise ApiException::Unauthorized, 'Your login or password are incorrect'
    end
  end

  def signup
    params[:user].each { |key, value| value.strip! if value.is_a? String }
    params[:user][:phone] = @client.lookups.phone_numbers(user_params[:phone]).fetch(type: ["carrier"]).phone_number
    user = User.create!(user_params)
    render json: UserBlueprint.render(user, view: :auth, root: :data)
  end

  def forgot_password
    user = User.find_by!(email: params[:email])
    create_reset_password_token(user)
    send_reset_password(user)
    render json: UserBlueprint.render(root: :data)
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

  def send_reset_password(user)
    from = Email.new(email: 'andrewfamilyfinding@weblightdevelopment.com')
    to = Email.new(email: user.email)
    subject = 'Reset Password at Family Finding'
    content = Content.new(type: 'text/html', value: "<html>
      <p>Hi there!</p>
      <p> You requested to change your password. You can do this through the link below.</p>
      <a href='https://family-finding-webapp.herokuapp.com/new-password?token=#{@token}'>Change password<a/> 
      <p> If you didn't request this, please ignore this email.</p>
      <p> Your password won't change until you access the link above and create a new one. </p>
      </html>")
      # http://localhost:3001
      
    mail = SendGrid:: Mail.new(from, subject, to, content)
    
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.body
    # puts response.headers
  end

  def create_reset_password_token(user)
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    @token = raw
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save
  end

  def user_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :email,
        :organization_id,
        :phone,
        :role,
        :password,
        :password_confirmation
      )
  end
end
