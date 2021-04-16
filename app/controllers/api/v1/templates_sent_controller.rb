class Api::V1::TemplatesSentController < ApplicationController  
    def index
      render json: TemplatesSentBlueprint.render(communication_templates_scope, root: :data)
    end

    def generate_pdf
      @template_sent ||= TemplatesSent.find(params[:id])
      respond_to do |format|  
        format.pdf do
          pdf = Prawn::Document.new
          pdf.markup(@template_sent.content)
          pdf.markup_options = {
            table: { header: { style: :bold, background_color: 'FFFFDD' } }
          }
          send_data pdf.render,
            filename: "export.pdf",
            type: 'application/pdf',
            disposition: 'inline'
        end
      end
    end

    private

    def communication_templates_scope
      TemplatesSent.filter_by_contact_id(params[:id])
    end
  end
  