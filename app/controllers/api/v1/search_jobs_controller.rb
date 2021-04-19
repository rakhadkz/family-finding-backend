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

  def call_webhook_cheerio
    dataset_id = search_job_params[:resource]["default_dataset_id"]
    last_task_id = search_job_params[:event_data]["actor_run_id"]
    puts last_task_id

    raise ArgumentError.new "No dataset provided" if dataset_id.nil?
    response = JSON.parse(URI.parse("https://api.apify.com/v2/datasets/#{dataset_id}/items?clean=true&format=json&token=#{ENV["APIFY_TOKEN"]}").read)
    cheerioRun = CheerioSearch.where(last_task_id: last_task_id)
    raise ArgumentError.new "No cheerio run provided" if cheerioRun.nil?
    retry_count = cheerioRun[0]["retry_count"]
    if response.length() == 0 && retry_count <= 15
      puts "HEllo"
      family_search_by_last_run = FamilySearch.find(cheerioRun[0]["family_search_id"])
      puts family_search_by_last_run.child_contact
      if cheerioRun[0]["url"].nil?
        puts "WWS"
        request_result = send_request(family_search_by_last_run)
        puts request_result
        cheerioRun.update(retry_count: retry_count + 1, last_task_id: request_result["data"]["id"])
      else
        request_result = send_cheerio_relative_request(family_search_by_last_run, cheerioRun[0]["url"])
        cheerioRun.update(retry_count: retry_count + 1, last_task_id: request_result["data"]["id"])
      end
    else
      puts "ELSE HELLOW 2"
      puts response[0]["family_search_id"]
      family_search_id = response[0]["family_search_id"]
      raise ArgumentError.new "Family Search not found" if family_search_id.nil?
      result_type = response[0]["result_type"]
      family_search = FamilySearch.find(family_search_id)
      description = response[0]["description"]
      puts response[0]["addresses"]
      puts response[0]["addresses"].length()
      puts response[0]["phone_numbers"]
      puts response[0]["phone_numbers"].length()
      puts result_type
      puts description
      puts "EMAILS"
      puts response[0]["emails"]
      puts "EMAILS 1"

      if result_type == 'main'
        is_link_alert = response[0]["is_link_alert"] || false
        relatives = response[0]["relatives"]
        family_search.update!(
          description: description,
          is_link_alert: is_link_alert,
          relatives_count: relatives.length(),
          current_relatives: 0
        )
        puts "relative 1"

        puts relatives
        puts "relative 2"

        response[0]["addresses"].each { |address| Communication.find_or_create_by({communication_type: "address", value: address, contact_id: family_search.child_contact_id }) }
        response[0]["phone_numbers"].each { |phone| Communication.find_or_create_by({communication_type: "phone", value: phone, contact_id: family_search.child_contact_id }) }
        response[0]["emails"].each { |email| Communication.find_or_create_by({communication_type: "email", value: email, contact_id: family_search.child_contact_id }) }
        relatives.each do |relative|
          sendedRelativeRequest = send_cheerio_relative_request(family_search, relative["fastpeople_url"])
          CheerioSearch.create!({last_task_id: sendedRelativeRequest["data"]["id"], family_search_id:family_search.id, retry_count:0, url: relative["fastpeople_url"] })
        end
      else
        new_description = family_search.description + description
        is_link_alert = response[0]["is_link_alert"] || false
        contact = Contact.find_or_create_by({first_name: response[0]["full_name"].split[0], last_name: response[0]["full_name"].split[1]})
        child_contact = ChildContact.create!(child_id:family_search.child_id,contact_id:contact.id)
        response[0]["addresses"].each { |address| Communication.find_or_create_by({communication_type: "address", value: address, contact_id: contact.id }) }
        response[0]["phone_numbers"].each { |phone| Communication.find_or_create_by({communication_type: "phone", value: phone, contact_id: contact.id }) }
        response[0]["emails"].each { |email| Communication.find_or_create_by({communication_type: "email", value: email, contact_id: contact.id }) }
        family_search.update!(
          description: new_description,
          is_link_alert: is_link_alert,
          current_relatives: family_search.current_relatives + 1
        )
        
        if family_search.relatives_count == family_search.current_relatives
          family_search.update!(date_completed: Time.now)
        end
      end
      render status: :ok
    end
  end

  def call_webhook
    dataset_id = search_job_params[:webhook]["default_dataset_id"] || search_job_params[:webhook]["defaultDatasetId"]
    raise ArgumentError.new "No dataset provided" if dataset_id.nil?
    response = URI.parse("https://api.apify.com/v2/datasets/#{dataset_id}/items?clean=true&format=json&token=#{ENV["APIFY_TOKEN"]}").read
    family_search_id = JSON.parse(response)[0]["family_search_id"]
    raise ArgumentError.new "Family Search not found" if family_search_id.nil?
    family_search = FamilySearch.find(family_search_id)
    description = JSON.parse(response)[0]["description"]
    if Digest::SHA1.hexdigest(description) != family_search.hashed_description
      is_link_alert = JSON.parse(response)[0]["is_link_alert"] || false
      family_search.update!(
        description: description,
        hashed_description: Digest::SHA1.hexdigest(description),
        is_link_alert: is_link_alert
      )
      attachments = JSON.parse(response)[0]["attachments"] || []
      attachments.each do |attachment|
        next if Attachment.where(file_name: attachment["file_name"]).count > 0
        new_attachment = Attachment.create!(**attachment, user_id: family_search.user_id)
        new_attachment.child_contact_attachments.create!(child_contact_id: family_search.child_contact_id)
        new_attachment.family_search_attachments.create!(family_search_id: family_search_id)
      end
      contacts = JSON.parse(response)[0]["contacts"] || []
      contacts.each do |contact|
        existing = Contact.where(:first_name => contact.first_name, :last_name => contact.last_name, :birthday => contact.birthday)
        if(existing.length == 0)
          new_contact = Contact.create!(contact.except("relationship"))
          new_connection = new_contact.child_contacts.create!(child_id: family_search.child_id, relationship: contact["relationship"])
          new_connection.family_search_connections.create!(family_search_id: family_search_id)
        end
      end
    end
    family_search.update!(date_completed: Time.now)
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
    if family_search
      raise ArgumentError.new "Connection id cannot be nil" if family_search.child_contact_id.nil?
      result = send_request(family_search)
      if ENV["CHEERIO_TASKS"].split.include?(search_vector.task_id)
        CheerioSearch.create!({last_task_id: result["data"]["id"], family_search_id: family_search.id, retry_count:0 })
      end
    else
      scope.each do |family_search|
        result = send_request(family_search)
        if ENV["CHEERIO_TASKS"].split.include?(search_vector.task_id)
          CheerioSearch.create!({last_task_id: result["data"]["id"], family_search_id: family_search.id, retry_count:0 })
        end
      end
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

  def send_request(family_search_input)
    puts "HELLO BROTHER"
    raise ArgumentError.new "Connection of the Search Result cannot be null" if family_search_input.child_contact.nil?
    family_search_input.update date_completed: nil
    puts "HELLO BROTHER 2"
    search_vector = SearchVector.find(family_search_input.search_vector_id)
    uri = URI.parse("https://api.apify.com/v2/actor-tasks/#{search_vector.task_id}/runs?token=#{ENV["APIFY_TOKEN"]}")
    puts "HELLO BROTHER 3"
    header = { "Content-Type": 'application/json' }
    puts "HELLO BROTHER 4"
    body = request_body(family_search_input)
    puts "HELLO BROTHER 5"
    http = Net::HTTP.new(uri.host, uri.port)
    puts "HELLO BROTHER 6"
    http.use_ssl = true
    puts "HELLO BROTHER 7"
    http.read_timeout = 100
    puts "HELLO BROTHER 8"
    request = Net::HTTP::Post.new(uri.request_uri, header)
    puts "HELLO BROTHER 9"
    request.body = body.to_json
    puts "HELLO BROTHER 10"

    JSON.parse(http.request(request).body)
  end

  def send_cheerio_relative_request(family_search_input, relative_url)
    raise ArgumentError.new "Connection of the Search Result cannot be null" if family_search_input.child_contact.nil?
    family_search_input.update date_completed: nil
    uri = URI.parse("https://api.apify.com/v2/actor-tasks/#{ENV["CHEERIO_RELATIVES_TASK"]}/runs?token=#{ENV["APIFY_TOKEN"]}")
    header = { "Content-Type": 'application/json' }
    body = {
      customData: {
        family_search_id: family_search_input.id,
        url: relative_url
      }
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 100
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json
    JSON.parse(http.request(request).body)
  end

  def request_body(family_search)
    first_name = family_search.child_contact.contact.first_name
    last_name = family_search.child_contact.contact.last_name
    sex = family_search.child_contact.contact.sex
    city = family_search.child_contact.contact.city
    state = family_search.child_contact.contact.state
    birthday = family_search.child_contact.contact.birthday
    {
      customData: {
        firstName: first_name,
        lastName: last_name,
        birthday: birthday,
        family_search_id: family_search.id,
        sex: sex,
        city: city,
        state: state
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
        :webhook => {},
        :event_data => {},
        :resource => {}
      )
  end

end
