class Api::V1::LinkScoresController < ApplicationController

  def index

  end

  def show

  end

  private

  def connection
    @connection ||= ChildContact.find(link_score_params[:child_contact_id])
  end

  def link_score_params
    params.require(:link_score)
      .permit(:child_contact_id)
  end

end
