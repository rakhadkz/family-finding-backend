Rake::Task.clear
class Api::V1::SearchJobsController < ApplicationController

  def call_rake
    task = "search_" + search_job_params[:task].gsub(/[[:space:]]/, '') # prevent users from malicious tasks like db:drop
    options = [ search_job_params[:first_name], search_job_params[:last_name] ]
    load File.join(Rails.root, 'lib', 'tasks', 'search_pa_megan.rake')
    Rake::Task[task].execute(options)
  end

  private

  def search_job_params
    params.require(:search_job)
      .permit([
        :task,
        :first_name,
        :last_name
      ])
  end

end
