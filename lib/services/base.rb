module Services
  module Base
    include ErrorLogger
 
    extend ActiveSupport::Concern
 
    class_methods do
      def call(*args)
        new(*args).call
      end
    end
 
    def handle_error(ex)
      puts(ex)
 
      error_code = ex.instance_of?(ActiveRecord::RecordNotFound) ? 404 : 500
 
      Services::Result.new(error_code: error_code)
    end
  end
end