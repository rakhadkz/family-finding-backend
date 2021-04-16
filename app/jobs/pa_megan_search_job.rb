Rake::Task.clear

class PaMeganSearchJob < ApplicationJob
  queue_as :default

  def perform(options)
    puts options
  end
end
