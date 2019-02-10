client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['COONMINER_CONSUMER_KEY']
  config.consumer_secret     = ENV['COONMINER_CONSUMER_SECRET']
  config.access_token        = ENV['COONMINER_ACCESS_TOKEN']
  config.access_token_secret = ENV['COONMINER_ACCESS_TOKEN_SECRET']
end
