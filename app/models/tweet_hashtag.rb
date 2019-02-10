class TweetHashtag < ActiveRecord::Base
  validates :tweet_id,   presence: true, allow_blank: false
  validates :hashtag_id, presence: true, allow_blank: false

  belongs_to :tweet
  belongs_to :hashtag
end
