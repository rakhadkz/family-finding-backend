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
      status_callback: "https://family-finding-api-dev.herokuapp.com/twilio_webhook/0987654321poiuytrewq"
    ) 
    return message.sid
  end

  def self.available_phone_numbers()
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    mobile = @client.available_phone_numbers('US').local.list(limit: 20)
    phone_numbers = []
    mobile.each do |record|
      phone_numbers.push({phone_number: record.phone_number, friendly_name: record.friendly_name })
    end
    phone_numbers
  end

  def self.choose_phone_number()
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    incoming_phone_number = @client.incoming_phone_numbers.create(phone_number: '+12067078526')
    puts incoming_phone_number.sid
  end
end