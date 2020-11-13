class Api::V1::SiblingsController < ApplicationController

  before_action :authenticate_request!
  before_action :set_child, only: [:create, :delete, :get_siblings]
  before_action :set_siblings, only: [:get_siblings]

  def get_siblings
    render json: SiblingshipBlueprint.render(@siblings, root: :data)
  end

  def create
    @siblingship = @child.siblingships.build(:sibling_id => params[:sibling_id])
    if @siblingship.save
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def delete
    @siblingship = Siblingship
      .where('sibling_id = ? or child_id = ?', params[:child_id], params[:child_id])
        .find(params[:id])
    @siblingship.destroy
    render status: :ok
  end

  private
  def set_child
    @child = Child.find(params[:child_id])
  end

  private
  def set_siblings
    @siblings = @child.inverse_siblings + @child.siblings
  end
end
