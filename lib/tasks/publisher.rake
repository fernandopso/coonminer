task :publisher, [:id] => :environment do |task, args|

  if args.id.present?
    token = Token.find(args.id.to_i)
  else
    token = Token.active.publics.cron_active.publishables.publish_at_asc.first
  end

  if Rails.env.production?
    Publisher.new(token).hashtag
  else
    Publisher.new(token).hashtag
    Publisher.new(token).language
    Publisher.new(token).location
    Publisher.new(token).link
  end
end

task :publisher_news, [:id] => :environment do |task, args|
  token = Token.active.publics.cron_active.publishables.publish_at_asc.last
  Publisher.new(token).link
end
