class Tweet < ActiveRecord::Base
  POSITIVE = 'positive'
  NEGATIVE = 'negative'
  NEUTRAL  = 'neutral'

  RATE_ADAPTER = { POSITIVE =>  1, NEUTRAL  =>  0, NEGATIVE => -1 }

  validates :text, presence: true, allow_blank: false
  validates :url, presence: true, allow_blank: false
  validates_uniqueness_of :url, scope: :token_id
  validates_uniqueness_of :uuid
  validates :token_id, presence: true

  belongs_to :token

  scope :user_unrated, ->  { where(rate: nil) }
  scope :user_positive, -> { where(rate: POSITIVE) }
  scope :user_negative, -> { where(rate: NEGATIVE) }
  scope :user_neutral, ->  { where(rate: NEUTRAL)  }

  scope :svm_unrated, ->  { where(rate_svm: nil) }
  scope :svm_positive, -> { where(rate_svm: POSITIVE) }
  scope :svm_negative, -> { where(rate_svm: NEGATIVE) }
  scope :svm_neutral, ->  { where(rate_svm: NEUTRAL)  }

  scope :not_rated_by_anyone, -> { where(rate_open: nil) }

  scope :positive, -> { where('rate=? OR rate_svm=?', POSITIVE, POSITIVE) }
  scope :negative, -> { where('rate=? OR rate_svm=?', NEGATIVE, NEGATIVE) }
  scope :neutral, ->  { where('rate=? OR rate_svm=?', NEUTRAL,  NEUTRAL)  }

  scope :where_rate_user, ->(rate) { where(rate: rate) }
  scope :where_rate_svm, ->(rate) { where(rate_svm: rate) }

  scope :user_rated, -> { where.not(rate: nil) }
  scope :svm_rated, -> { where.not(rate_svm: nil) }

  scope :user_or_svm_rated,          -> { where("rate!='' or rate_svm!=''") }
  scope :user_or_svm_rated_positive, -> { where("rate='positive' or rate_svm='positive'") }
  scope :user_or_svm_rated_neutral,  -> { where("rate='neutral' or rate_svm='neutral'") }
  scope :user_or_svm_rated_negative, -> { where("rate='negative' or rate_svm='negative'") }

  scope :not_rated, -> { where(rate: nil) }
  scope :not_rated_svm, -> { where(rate_svm: nil) }

  scope :replies, -> { where(reply: true) }
  scope :not_reply, -> { where(reply: false) }
  scope :where_reply, ->(reply) { where(reply: reply) }

  scope :retweets, -> { where(retweet: true) }
  scope :not_retweet, -> { where(retweet: false) }
  scope :where_retweet, ->(retweet) { where(retweet: retweet) }
  scope :where_language, ->(lang) { where(lang: lang) }

  scope :validates_by_users, -> { where.not(svm_rate_validate: nil) }
  scope :validates_correct, -> { where(svm_rate_validate: true) }

  scope :'1h',  -> { where('publish_at BETWEEN ? AND ?', (Time.now - 1.hours),  Time.now) }
  scope :'3h',  -> { where('publish_at BETWEEN ? AND ?', (Time.now - 3.hours),  Time.now) }
  scope :'12h', -> { where('publish_at BETWEEN ? AND ?', (Time.now - 12.hours), Time.now) }
  scope :'24h', -> { where('publish_at BETWEEN ? AND ?', (Time.now - 24.hours), Time.now) }
  scope :'3d',  -> { where('publish_at BETWEEN ? AND ?', (Time.now - 3.days),   Time.now) }
  scope :'7d',  -> { where('publish_at BETWEEN ? AND ?', (Time.now - 7.days),   Time.now) }

  scope :more_than_seven_days, -> { where('created_at BETWEEN ? AND ?', (DateTime.current.beginning_of_day - 100.days), (DateTime.current.beginning_of_day - 7.days)) }

  scope :publish_at_desc, -> { order('publish_at desc') }
  scope :publish_at_asc, -> { order('publish_at asc') }

  scope :with_links, -> { where.not(href: nil) }
  scope :with_hashtags, -> { where.not(hashtag: nil) }
  scope :with_mentions, -> { where.not(mention: nil) }
  scope :with_languages, -> { where.not(lang: nil) }
  scope :with_locations, -> { where.not(location: nil) }

  before_create do
    self.uuid = SecureRandom.uuid unless self.uuid
  end

  def rate_to_i
    RATE_ADAPTER[self.rate]
  end
end
