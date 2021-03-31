Rake::Task.clear
require 'rake'
require 'net/https'
require 'json'
require 'open-uri'

class Api::V1::SearchJobsController < ApplicationController
  def ready
    if( FamilySearch.find(search_job_params[:family_search_id]).date_completed != nil )
      render json: { message: "ready" }, status: :ok
    else
      render json: { message: "not ready" }, status: :ok
    end
  end

  def call_webhook
    dataset_id = search_job_params[:webhook]["default_dataset_id"]
    raise ArgumentError.new "No dataset provided" if dataset_id.nil?
    response = URI.parse("https://api.apify.com/v2/datasets/#{dataset_id}/items?clean=true&format=json&token=#{ENV["APIFY_TOKEN"]}").read
    description = JSON.parse(response)[0]["description"]
    family_search_id = JSON.parse(response)[0]["family_search_id"]
    raise ArgumentError.new "Family Search not found" if family_search_id.nil?
    family_search = FamilySearch.find(family_search_id)
    if Digest::SHA1.hexdigest(description) != family_search.hashed_description
      family_search.description = description
      family_search.hashed_description = Digest::SHA1.hexdigest(description)
      family_search.is_link_alert = true if family_search.is_link_alert === false || family_search.is_link_alert.nil?
    end
    family_search.date_completed = Time.now
    family_search.save
    render status: :ok
  end

  def call_rake
    rake = Rake.application
    rake.load_rakefile
    task = "search_#{task_name.gsub(/[[:space:]]/, '')}"
    rake[task].execute(search_job_params)
    render json: { message: "success", search_vector_id: search_vector_id, task_name: task_name }, status: :ok
  end

  def call_apify_task
    if search_job_params[:family_search_id].present?
      family_search = FamilySearch.find search_job_params[:family_search_id]
      raise ArgumentError.new "Connection id cannot be nil" if family_search.child_contact_id.nil?
      send_request family_search
    else
      scope.each { |family_search| send_request family_search }
    end
    render json: { message: "success", search_vector_id: search_vector_id }, status: :ok
  end

  private

  def get_task_name
    Generator.generate_username(search_vector.name)
  end

  def task_name
    case search_vector_id
    when BOP
      "bop"
    when UJS
      "ujsportal_pacourts_us"
    when PAMEGAN
      "pa_megan"
    else
      "bop"
    end
  end

  def scope
    FamilySearch.filter_by_search_vector_for_job(search_vector_id)
  end

  def send_request(family_search)
    return if family_search.child_contact.nil?
    family_search.update date_completed: nil
    uri = URI.parse("https://api.apify.com/v2/actor-tasks/#{search_vector.task_id}/runs?token=#{ENV["APIFY_TOKEN"]}")
    header = { "Content-Type": 'application/json' }
    body = request_body(family_search)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 100
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json
    response = JSON.parse(http.request(request).body)

    puts "======================"
    puts response
    puts "======================"


    # if Digest::SHA1.hexdigest(response).to_s != family_search.hashed_description
    #   family_search.description = response
    #   family_search.hashed_description = Digest::SHA1.hexdigest(response).to_s
    #   family_search.is_link_alert = true if family_search.is_link_alert === false || family_search.is_link_alert.nil?
    # end

    # family_search.date_completed = Time.now
    # family_search.save
  end

  def request_body(family_search)
    first_name = family_search.child_contact.contact.first_name
    last_name = family_search.child_contact.contact.last_name
    birthday = family_search.child_contact.contact.birthday
    {
      customData: {
        firstName: first_name,
        lastName: last_name,
        birthday: birthday.present? ? birthday.strftime("%m%d%Y") : nil,
        family_search_id: family_search.id
      }
    }
  end

  def search_vector_id
    family_search.search_vector_id
  end
  
  def search_vector
    @search_vector ||= SearchVector.find(family_search.search_vector_id)
  end

  def family_search
    @family_search ||= FamilySearch.find(search_job_params[:family_search_id])
  end

  def search_job_params
      params.require(:search_job)
      .permit(
        :task,
        :first_name,
        :last_name,
        :family_search_id,
        :webhook => {}
      )
  end

end
