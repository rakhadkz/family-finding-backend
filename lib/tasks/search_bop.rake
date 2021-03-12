desc "Search BOP website"
task :search_bop, [:options] => :environment do |t, args|
  BopSearchJob.perform_now(args)
end
