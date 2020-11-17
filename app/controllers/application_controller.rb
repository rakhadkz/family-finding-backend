class ApplicationController < ActionController::API
  include ApiException
  MAX_PER_PAGE = 20

  def authenticate_request!
    raise ApiException::InvalidToken if auth_token.nil?
    @current_user ||= User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    raise ApiException::InvalidToken
  end

  protected

  def page_info(paginated_scope)
    total_count = paginated_scope.total_count

    {
      page: paginated_scope.current_page,
      num_pages: (total_count / per_page).to_i + 1,
      per_page: per_page,
      total_count: total_count,
    }
  end

  def per_page
    [(params[:per_page] || MAX_PER_PAGE).to_i, MAX_PER_PAGE].min
  end

  private

  def auth_token
    http_token = bearer_token || params['token']
    @auth_token ||= JsonWebToken.decode(http_token) unless http_token.nil?
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end

  def require_super_admin
    if @current_user && !@current_user.role === 'super_admin'
      raise ApiException::Unauthorized
    end
  end

  def require_admin
    if @current_user && !@current_user.role === 'admin'
      raise ApiException::Unauthorized
    end
  end

  def require_manager
    if @current_user && !@current_user.role === 'manager'
      raise ApiException::Unauthorized
    end
  end

  def require_user
    if @current_user && !@current_user.role === 'user'
      raise ApiException::Unauthorized
    end
  end

  def view
    case params[:view]
    when 'short'
      @view ||= :short
    when 'sidebar_profile'
      @view = :sidebar_profile
    when 'attachments'
      @view = :attachments
    when 'siblings'
      @view = :siblings
    when 'contacts'
      @view = :contacts
    else
      @view ||= :extended
    end
  end

end
