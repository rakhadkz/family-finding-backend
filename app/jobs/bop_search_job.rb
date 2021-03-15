Rake::Task.clear
require 'json'
require 'digest/sha1'

class BopSearchJob < ApplicationJob
  queue_as :default

  def perform(options)
    if options[:family_search_id].present?
      family_search = FamilySearch.find options[:family_search_id]
      family_search.update date_completed: nil
      raise ArgumentError.new "Connection id cannot be nil" if family_search.child_contact_id.nil?
      raise ArgumentError.new "Not BOP search vector!" if family_search.search_vector_id != 10
      send_request family_search
    else
      scope.update_all date_completed: nil
      scope.each { |family_search| send_request family_search }
    end
  end

  private
  def scope
    FamilySearch.where(search_vector_id: 10, date_accepted: nil, date_rejected: nil)
  end

  def send_request(family_search)
    return if family_search.child_contact.nil?
    first_name = family_search.child_contact.contact.first_name
    last_name = family_search.child_contact.contact.last_name
    uri = URI("https://www.bop.gov/PublicInfo/execute/inmateloc?todo=query&output=json&nameFirst=#{first_name}&nameLast=#{last_name}")
    response = Net::HTTP.get(uri)
    description = "<table style='border-collapse: inherit;'><tr><th>First Name</th><th>Last Name</th><th>Age</th><th>Race</th><th>Sex</th></tr>"
    if Digest::SHA1.hexdigest(JSON.parse(response)["InmateLocator"].to_s) != family_search.hashed_description
      JSON.parse(response)["InmateLocator"].each do |object|
        description += "<tr><td>#{object["nameFirst"]}</td><td>#{object["nameLast"]}</td><td>#{object["age"]}</td><td>#{object["race"]}</td><td>#{object["sex"]}</td></tr>"
      end
      description += "</table>"
      family_search.description = description
      family_search.hashed_description = Digest::SHA1.hexdigest(description)
      family_search.date_completed = Time.now
      family_search.save
    end
  end
end
