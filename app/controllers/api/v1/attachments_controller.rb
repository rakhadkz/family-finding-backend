class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_att, only: [:show, :update, :destroy]

  def create
    attachment = Attachment.create!(attachment_params)
    render json: AttachmentBlueprint.render(attachment, root: :data)
  end

  def show
    render json: AttachmentBlueprint.render(@attachment, root: :data)
  end

  def update
    @attachment.update!(attachment_params)
    render json: AttachmentBlueprint.render(@attachment, root: :data)
  end

  def destroy
    @attachment.destroy
    render json: :ok
  end

  private

  def set_att
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment)
        .permit([
                    :child_id,
                    :filename,
                    :filetype,
                    :filelocation
                ])
  end

end
