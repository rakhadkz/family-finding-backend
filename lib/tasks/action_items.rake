desc "Run this job every 24 hours to create an action item for every user of a child that hits modulus 30 days in system"
task :action_items => :environment do
  ActionItemsJob.perform_now
end
