require 'net/https'
desc "search_ujsportal_pacourts_us"
task :search_ujsportal_pacourts_us, [:options] => :environment do |t, args|
  UjsportalPacourtsUsJob.perform_now(args)
end
