module TwilioPhone
  def self.format(params)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.lookups.phone_numbers(params[:phone]).fetch(type: ["carrier"]).phone_number
  end
end