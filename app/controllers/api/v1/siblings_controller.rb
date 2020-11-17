class Api::V1::SiblingsController < ApplicationController
  before_action :authenticate_request!

  def get_siblings
    render json: SiblingshipBlueprint.render(siblings, root: :data)
  end

  def create
    siblingship = child.siblingships.build(:sibling_id => params[:sibling_id])
    siblingship.save!
  end

  def delete
    siblingship.destroy!
    render status: :ok
  end

  private

  def child
    @child ||= Child.find(params[:child_id])
  end

  def siblings
    @siblings ||= child.inverse_siblings + child.siblings
  end

  def siblingship
    @siblingship ||= Siblingship
      .where('sibling_id = ? or child_id = ?', params[:child_id], params[:child_id])
        .find(params[:id])
  end

end
