class Api::V1::ChildrenController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!

  def index
    results = sort(search(filter(children_scope)))
    children = params[:page] ? results.page(params[:page]).per(per_page) : children_scope
    render json: ChildBlueprint.render(children, root: :data, view: view, user: @current_user, meta: params[:page].present? ? page_info(children) : nil)
  end

  def show
    render json: ChildBlueprint.render(child, view: view, user: @current_user, root: :data)
  end

  def create
    child = Child.create!(child_params)
    render json: ChildBlueprint.render(child, root: :data)
  end

  def update
    child.update!(child_params)
    render json: ChildBlueprint.render(child, root: :data)
  end

  def destroy
    child.destroy!
    head :ok
  end

  private

  def children_scope
    case params[:sort]
    when "days_in_system_asc"
      Child.all.order(created_at: :desc)
    when "days_in_system_desc"
      Child.all.order(created_at: :asc)
    when "connections_asc"
      Child.left_outer_joins(:contacts).group(:id).order('COUNT(contacts.id) asc')
    when "connections_desc"
      Child.left_outer_joins(:contacts).group(:id).order('COUNT(contacts.id) desc')
    else
      Child.all
    end
  end

  def child
    child = Child.includes(:child_contacts, :contacts).find(params[:id])
    has_access ? child : {
      first_name: child.first_name,
      last_name: child.last_name,
      request_pending: @current_user.user_children.find_by(child_id: params[:id], date_approved: nil, date_denied: nil).present?,
    }
  end

  def has_access
    @current_user.children.find_by(id: params[:id]).present? || @current_user.role != "user"
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :birthday, :permanency_goal, :continuous_search, :race, :gender, :school_district_id, :system_status)
  end
end
