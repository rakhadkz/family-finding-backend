class Api::V1::ChildrenController < ApplicationController
  before_action :authenticate_request!
=begin
  before_action :require_organization_user
=end

  before_action :set_child, only: [:show, :update, :destroy, :get_siblings, :add_sibling, :remove_sibling]
  before_action :set_siblings, only: [:get_siblings]

  # GET /children
  def index
    @children = Child.all

    render json: @children
  end

  # GET /children/1
  def show
    render json: @child
  end

  # POST /children
  def create
    @child = Child.new(child_params)

    if @child.save
      render json: @child, status: :created
    else
      render json: @child.errors, status: :unprocessable_entity
    end
  end

  def add_sibling
    @siblingship = @child.siblingships.build(:sibling_id => params[:sibling_id])
    if @siblingship.save
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def remove_sibling
    @siblingship = @child.siblingships.find(params[:sibling_id])
    @siblingship.destroy
    render status: :ok
  end

  def get_siblings
    render json: @siblings
  end

  # PATCH/PUT /children/1
  def update
    if @child.update(child_params)
      render json: @child
    else
      render json: @child.errors, status: :unprocessable_entity
    end
  end

  # DELETE /children/1
  def destroy
    @child.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

  private
    def set_siblings
      @siblings = @child.inverse_siblings + @child.siblings
    end

  private
    # Only allow a trusted parameter "white list" through.
    def child_params
      params.require(:child).permit(:first_name, :last_name, :birthday)
    end
end
