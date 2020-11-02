module JsonWebToken
  require 'jwt'

  def self.encode(payload, expiration)
    payload[:exp] = expiration
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  end

end
