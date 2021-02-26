class Api::V1::FamilySearchAttachmentsController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: FamilySearchAttachmentBlueprint.render(FamilySearchAttachment.all, root: :data)
  end

  def show
    render json: FamilySearchAttachmentBlueprint.render(family_search_attachment, root: :data)
  end

  def create
    family_search_attachment = FamilySearchAttachment.create!(fs_attachment_params)
    render json: FamilySearchAttachmentBlueprint.render(family_search_attachment, root: :data)
  end

  def update
    family_search_attachment.update!(fs_attachment_params)
    render json: FamilySearchAttachmentBlueprint.render(family_search_attachment, root: :data)
  end

  def destroy
    family_search_attachment.destroy!
    head :ok
  end

  private
  def family_search_attachment
    @family_search_attachment ||= FamilySearchAttachment.find(params[:id])
  end

  def fs_attachment_params
    params
      .require(:family_search_attachment)
      .permit([
                :family_search_id,
                :attachment_id
              ])
  end
end
