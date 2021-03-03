desc "Print reminder about eating more fruit."
task :first_task => :environment do
    FirstJob.perform_now('Onyn')
end

task :second_task => :environment do
  SampleJob.set(wait: 3.second).perform_later
end

namespace :practice do
  task :comment_counter => :environment do
    SampleJob.perform_now
  end
end

namespace :cooking do
  task :mac_and_cheese => [:boil_water] do
    puts "Making Mac and Cheese"
  end

  task :buy_cheese => :shop do
    puts "Buying Cheese"
  end

  task :buy_pasta => :shop do
    puts "Buying Pasta"
  end

  task :boil_water => [:buy_pasta, :buy_cheese] do
    puts "Boiling Water"
  end

  task :shop do
    puts "Shopping"
  end
end
