GoodJob::Engine.middleware.use(Rack::Auth::Basic) do |username, password|
  ActiveSupport::SecurityUtils.secure_compare('admin', username) &&
    ActiveSupport::SecurityUtils.secure_compare(ENV['GOOD_JOB_PASSWORD'], password)
end