module TwilioPhone
  def self.format(params)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.lookups.phone_numbers(params[:phone]).fetch(type: ["carrier"]).phone_number
  end

  def self.send(params)
    @client = Twilio::REST::Client.new(ENV['TWILIO_MESSAGE_ACCOUNT_SID'], ENV['TWILIO_MESSAGE_AUTH_TOKEN'])
    message = message = @client.messages.create( 
      body: params[:content],  
      messaging_service_sid: 'MG89460dc0d3b9ce3ba5984b40e8cc749b',      
      to: params[:phone],
      status_callback: "https://webhook.site/deb3e9b0-7dc7-4772-acbc-2940797ce89b"
    ) 
    return message.sid
  end
end