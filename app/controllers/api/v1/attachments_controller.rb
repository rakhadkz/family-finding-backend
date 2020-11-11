class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_att, only: [:show, :update, :destroy]

  def show
    render json: @attachment
  end

  def update
    if @attachment.update(attachment_params)
      render json: @attachment
    else
      render json: @attachment.errors, status: :unprocessable_entity
    end
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
