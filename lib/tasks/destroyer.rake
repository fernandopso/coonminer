task :destroy_token, [:id] => :environment do |task, args|

  token = Token.find(args.id.to_i)
  token.statistics.destroy
  token.bag_of_word.destroy
  token.destroy

end
