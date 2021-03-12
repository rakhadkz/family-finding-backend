Rake::Task.clear
require 'rake'
class Api::V1::SearchJobsController < ApplicationController

  def ready
    if( FamilySearch.find(search_job_params[:family_search_id]).date_completed != nil ) 
      render json: { message: "ready" }, status: :ok
    else 
      render json: { message: "not ready" }, status: :ok
    end
  end


  def call_rake
    rake = Rake.application
    rake.load_rakefile
    task = "search_" + search_job_params[:task].gsub(/[[:space:]]/, '') # prevent users from malicious tasks like db:drop
    rake[task].execute(search_job_params)
    render json: { message: "success" }, status: :ok
  end

  private

  def search_job_params
      params.require(:search_job)
      .permit(
        :task,
        :first_name,
        :last_name,
        :family_search_id
      )
  end

end
