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
    render json: { data: search_job_params }
    # rake = Rake.application
    # rake.load_rakefile
    # task = "search_#{task_name.gsub(/[[:space:]]/, '')}"
    # rake[task].execute(search_job_params)
    # render json: { message: "success", search_vector_id: search_vector_id, task_name: task_name }, status: :ok
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
