class TwilioPhone

  def initialize(params)
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    @phone = params[:phone]
  end

  def format
    @client.lookups.phone_numbers(@phone).fetch(type: ["carrier"]).phone_number
  end
end