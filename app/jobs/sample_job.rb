class SampleJob < ApplicationJob
  queue_as :default

  def perform
    Comment.all.size
  end

end
