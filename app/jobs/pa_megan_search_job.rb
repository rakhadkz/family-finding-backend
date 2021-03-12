Rake::Task.clear

class PaMeganSearchJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  # require 'byebug'

  def perform(options)
    puts('==============JOBJOB==============', options.to_h,'4')
    endpoint = "https://www.pameganslaw.state.pa.us/Search/NameSearchResults?enteredFirstName="
    + "#{options[:first_name]}&enteredLastName=#{options[:last_name]}"
    + "&chkNameIncarcerated=true&chkNameIncarcerated=false&chkNameSoundex=true&chkNameSoundex=false"

    doc = Nokogiri::HTML.parse(open(endpoint))
    family_search = FamilySearch.find(options[:family_search_id])
    family_search.date_completed = DateTime.now
    family_search.description = doc
    family_search.save
    puts family_search
  end
end
