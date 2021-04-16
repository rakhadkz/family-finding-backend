Rake::Task.clear
require 'digest/sha1'
require 'nokogiri'
require 'net/https'
require 'json'

class UjsportalPacourtsUsJob < ApplicationJob
  queue_as :default
  TOKEN = "6SazwMxeqz9f3QLsExNWJ8tR7"
  SEARCH_VECTOR_ID = ApplicationController::UJS
  def perform(options)
    if options[:family_search_id].present?
      family_search = FamilySearch.find options[:family_search_id]

      raise ArgumentError.new "Connection id cannot be nil" if family_search.child_contact_id.nil?
      raise ArgumentError.new "Not Ujs search vector!" if family_search.search_vector_id != SEARCH_VECTOR_ID

      if options.key?(:webhook)
        dataset_id = options[:webhook]["default_dataset_id"]
        url = URI.parse("https://api.apify.com/v2/datasets/#{dataset_id}/items?clean=true&format=html")
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        puts res.body
        description = JSON.parse(res.body)[0]["description"]
        if Digest::SHA1.hexdigest(description) != family_search.hashed_description
          family_search.description = description
          family_search.hashed_description = Digest::SHA1.hexdigest(description)
          family_search.is_link_alert = true if family_search.is_link_alert === false || family_search.is_link_alert.nil?
        end
        family_search.date_completed = Time.now
        family_search.save
        puts "Successfully saved!"
        puts family_search.description
        puts "========"
      else
        send_request family_search
      end
    else
      scope.each { |item| send_request item }
    end
  end

  private
  def scope
    FamilySearch.filter_by_search_vector_for_job(SEARCH_VECTOR_ID)
  end

  def send_request(family_search)
    return if family_search.child_contact.nil?
    family_search.update date_completed: nil
    uri = URI.parse("https://api.apify.com/v2/actor-tasks/qfpI8LT6l00ylR9dT/run-sync-get-dataset-items?token=6SazwMxeqz9f3QLsExNWJ8tR7")
    header = { "Content-Type": 'application/json' }
    body = request_body(family_search)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 100
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json
    response = JSON.parse(http.request(request).body)[0]["description"]

    if Digest::SHA1.hexdigest(response) != family_search.hashed_description
      family_search.description = response
      family_search.hashed_description = Digest::SHA1.hexdigest(response)
      family_search.is_link_alert = true if family_search.is_link_alert === false || family_search.is_link_alert.nil?
    end

    family_search.date_completed = Time.now
    family_search.save
  end

  def request_body(family_search)
    first_name = family_search.child_contact.contact.first_name
    last_name = family_search.child_contact.contact.last_name
    birthday = family_search.child_contact.contact.birthday
    {
      startUrls: [
        {
          url: "https://ujsportal.pacourts.us/CaseSearch",
          method: "GET",
          userData: {
            firstName: first_name,
            lastName: last_name,
            birthday: birthday.present? ? birthday.strftime("%m%d%Y") : nil
          }
        }
      ]
    }
  end
end
