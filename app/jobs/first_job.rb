class FirstJob < ApplicationJob
  queue_as :default

  def perform(name)
    puts (name + ' Salamaleikum eken angimesi')
  end
end
