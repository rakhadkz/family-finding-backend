class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_attachment, only: [:show, :update, :destroy]

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

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment)
        .permit([
                    :file_name,
                    :file_type,
                    :file_url,
                    :file_size,
                    :user_id
                ])
  end

end
