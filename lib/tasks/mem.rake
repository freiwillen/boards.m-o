task :test_mem => :environment do

    Memprof.start

      bob = User.new
    Memprof.dump
    Memprof.stop
   
end
