class Api::V1::SiblingshipsController < ApplicationController
  before_action :authenticate_request!

  def index
    siblingships = Siblingship.all
    render json: SiblingshipBlueprint.render(siblingships, root: :data)
  end

  def show
    data = {
      siblings: JSON.parse(SiblingshipBlueprint.render(siblingship, view: view)),
      possible: JSON.parse(SiblingshipBlueprint.render(possible_relationships, view: view))
    }
    render json: {data: data}
  end

  def create
    siblingship = Siblingship.create!(siblingship_params)
    render json: SiblingshipBlueprint.render(siblingship, root: :data)
  end

  def destroy
    only_siblingship.destroy!
    head :ok
  end

  def possible
    render json: SiblingshipBlueprint.render(possible_relationships, view: view, root: :data)
  end

  private

  def only_siblingship
    @only_siblingship ||= Siblingship.find(params[:id])
  end

  def siblingship
    siblingship_res ||= Siblingship.where(child_id: params[:id]).or(Siblingship.where(sibling_id: params[:id]))
    wws ||= Siblingship.select(:sibling_id).where(child_id: params[:id])
    puts('HAAHHAHAHA',wws.map { |id| id["sibling_id"]}, 'wfw')
    wws2 ||= Siblingship.where(child_id: wws.map { |id| id["sibling_id"]})
    puts('HAAHHAHA 2222',wws2, 'wfw')
    @siblingship = siblingship_res
  end

  def possible_relationships
    siblingship_res ||= Siblingship.where(child_id: params[:id])
    sibling_ids ||= Siblingship.select(:sibling_id).where(child_id: params[:id])
    @possible_relationships ||= Siblingship.where(child_id: sibling_ids.map { |id| id["sibling_id"]}).where.not(sibling_id:  sibling_ids.map { |id| id["sibling_id"]})
  end

  def siblingship_params
    params.require(:siblingship)
      .permit([
        :child_id,
        :sibling_id
      ])
  end
end
