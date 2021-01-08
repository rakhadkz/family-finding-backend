class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: AttachmentBlueprint.render(attachment, view: view, root: :data)
  end

  def create
    attachment = Attachment.create!(attachment_params)
    render json: AttachmentBlueprint.render(attachment, root: :data)
  end

  def update
    attachment.update!(attachment_params)
    render json: AttachmentBlueprint.render(attachment, root: :data)
  end

  def destroy
    Cloudinary::Api.delete_resources([attachment.file_id])
    attachment.destroy!
    head :ok
  end

  private

  def attachment
    @attachment ||= Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment)
      .permit(
      [
        :file_name,
        :file_type,
        :file_url,
        :file_id,
        :file_format,
        :file_size,
        :user_id
      ])
  end

end
