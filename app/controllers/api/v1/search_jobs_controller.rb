Rake::Task.clear
class Api::V1::SearchJobsController < ApplicationController

  def ready
    if( FamilySearch.find(search_job_params[:family_search_id]).date_completed != nil ) 
      render json: { message: "ready" }, status: :ok
    else 
      render json: { message: "not ready" }, status: :ok
    end
  end


  def call_rake
    task = "search_" + search_job_params[:task].gsub(/[[:space:]]/, '') # prevent users from malicious tasks like db:drop
    options = [ search_job_params[:first_name], search_job_params[:last_name], search_job_params[:family_search_id] ]
    load File.join(Rails.root, 'lib', 'tasks', 'search_pa_megan.rake')
    Rake::Task[task].execute(options)
    render json: { message: "success" }, status: :ok
  end

  private

  def search_job_params
    params.require(:search_job)
      .permit([
        :task,
        :first_name,
        :last_name,
        :family_search_id
      ])
  end

end
