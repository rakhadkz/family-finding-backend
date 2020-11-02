module ErrorReporter
  def self.report(e, message = nil)
    if Rails.env.production?
      if message.nil?
        Rollbar.log('error', e)
      else
        Rollbar.log('error', e, message)
      end
    else
      message = message || ''
      if e.respond_to?('message') && e.respond_to?('backtrace')
        Rails.logger.error [[message, ':', e.message].join(' '), *e.backtrace].join($/)
      else
        Rails.logger.error [message, ': ', e.to_s].join('')
      end
    end
  end
end