module Services
  class Result
    attr_accessor :error_code, :value
 
    def initialize(params = {})
      @value = params[:value]
      @error_code = params[:error_code]
    end
 
    def success?
      error_code.nil?
    end
 
    def failed?
      error_code.present?
    end
  end
end