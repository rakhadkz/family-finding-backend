desc "Print reminder about eating more fruit."
task :first_task => :environment do
    FirstJob.perform_later('Onyn')
end