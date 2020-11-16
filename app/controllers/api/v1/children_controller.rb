class Api::V1::ChildrenController < ApplicationController
  before_action :authenticate_request!

  def index
    children = Child.all
    render json: ChildBlueprint.render(@children, root: :data)
  end

  def show
    render json: ChildBlueprint.render(child, root: :data)
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

  def child
    @child ||= Child.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :birthday)
  end

end
