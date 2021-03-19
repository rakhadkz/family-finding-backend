Rake::Task.clear
require 'json'
require 'digest/sha1'

class BopSearchJob < ApplicationJob
  queue_as :default
  SEARCH_VECTOR_ID = 10
  def perform(options)
    if options[:family_search_id].present?
      family_search = FamilySearch.find options[:family_search_id]
      raise ArgumentError.new "Connection id cannot be nil" if family_search.child_contact_id.nil?
      raise ArgumentError.new "Not BOP search vector!" if family_search.search_vector_id != SEARCH_VECTOR_ID
      send_request family_search
    else
      scope.each { |family_search| send_request family_search }
    end
  end

  private
  def scope
    FamilySearch.filter_by_search_vector_for_job(SEARCH_VECTOR_ID)
  end

  def send_request(family_search)
    return if family_search.child_contact.nil?
    first_name = family_search.child_contact.contact.first_name
    last_name = family_search.child_contact.contact.last_name
    uri = URI("https://www.bop.gov/PublicInfo/execute/inmateloc?todo=query&output=json&nameFirst=#{first_name}&nameLast=#{last_name}")
    response = Net::HTTP.get(uri)
    result = "<table style='border-collapse: inherit;'><tr><th>First Name</th><th>Last Name</th><th>Age</th><th>Race</th><th>Sex</th></tr>"
    if Digest::SHA1.hexdigest(JSON.parse(response)["InmateLocator"].to_s) != family_search.hashed_description
      family_search.update date_completed: nil
      JSON.parse(response)["InmateLocator"].each do |object|
        result += "<tr><td>#{object["nameFirst"]}</td><td>#{object["nameLast"]}</td><td>#{object["age"]}</td><td>#{object["race"]}</td><td>#{object["sex"]}</td></tr>"
      end
      result += "</table>"
      family_search.description = result
      family_search.hashed_description = Digest::SHA1.hexdigest(result)
      family_search.date_completed = Time.now
      family_search.save
    end
  end
end
