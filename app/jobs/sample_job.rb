class SampleJob < ApplicationJob
  queue_as :default

  def perform
    puts Comment.all.size
  end

end
