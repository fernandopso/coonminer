task :send_email => :environment do
  Deliver::UserMailer.example.deliver_now
  puts "Done"
end
