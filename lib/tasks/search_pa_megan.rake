desc "Search PaMegansLaw website"
task :search_pa_megan, [:t] => :environment do |t, args|
  PaMeganSearchJob.perform_now(args)
end
