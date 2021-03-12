Rake::Task.clear
require 'json'

class BopSearchJob < ApplicationJob
  queue_as :default

  def perform(options)
    uri = URI("https://www.bop.gov/PublicInfo/execute/inmateloc?todo=query&output=json&nameFirst=#{options[:first_name]}&nameLast=#{options[:last_name]}")
    family_search = FamilySearch.find(options[:family_search_id])
    response = Net::HTTP.get(uri)
    description = ""
    JSON.parse(response)["InmateLocator"].each do |object|
      description += "<p>First Name: <strong>#{object["nameFirst"]}</strong></p><p>Last Name: <strong>#{object["nameLast"]}</strong></p><p>Age: <strong>#{object["age"]}</strong></p><p>Race: <strong>#{object["race"]}</strong></p><p>Sex: <strong>#{object["sex"]}</strong></p>";
    end
    family_search.description = description
    family_search.save
  end
end
