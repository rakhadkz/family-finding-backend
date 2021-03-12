Rake::Task.clear

class PaMeganSearchJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  require 'byebug'
  
  def perform(*options)
    puts('==============JOBJOB==============', options,'4')
    endpoint = "https://www.pameganslaw.state.pa.us/Search/NameSearchResults?enteredFirstName="
       + options[0].to_s + "&enteredLastName=" + options[1].to_s
        + "&chkNameIncarcerated=true&chkNameIncarcerated=false&chkNameSoundex=true&chkNameSoundex=false"
    
        doc = Nokogiri::HTML.parse(open(endpoint))
    # puts(doc)
  end
end
