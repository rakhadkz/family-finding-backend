class Api::V1::OrganizationAdmin::UsersController < ApplicationController
  include Filterable
  include Searchable
  include Sortable

  before_action :authenticate_request!
  before_action :require_admin
  before_action :load_user, only: %i[
    show
    update
    destroy
  ]

  filterable_by 'users.role'
  sortable_by 'users.first_name', 'users.last_name', 'users.role'

  def index
    results = sort(search(filter(users_scope)))
    users = results.page(params[:page]).per(per_page)
    render json: UserBlueprint.render(users, root: :data, meta: page_info(users))
  end

  def create
    user = User.create!(user_params)
    render json: UserBlueprint.render(user, root: :data)
  end

  def update
    @user.update(user_params)
    render json: UserBlueprint.render(@user, root: :data)
  end

  def show
    render json: UserBlueprint.render(@user, root: :data)
  end

  def destroy
    @user.destroy
    head :ok
  end

  private

  def users_scope
    User.all
  end

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params
      .require(:user)
      .permit(
        [
          :email,
          :role,
          :first_name,
          :last_name
        ])
  end

end
