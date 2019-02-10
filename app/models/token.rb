class Token < ActiveRecord::Base
  # Constants -----------------------------------------------------------------
  MAX_TWEETS = 500

  # Concerns ------------------------------------------------------------------
  include TokenConcerns::Statusable
  include TokenConcerns::Trendable

  # Validations ---------------------------------------------------------------
  validates :word, presence: true, allow_blank: false
  validates :lang, presence: true, allow_blank: false

  # Associations --------------------------------------------------------------
  belongs_to :company
  belongs_to :category
  has_many :tweets
  has_many :hashtags
  has_many :languages
  has_many :locations
  has_many :mentions
  has_many :links
  has_many :profiles
  has_many :words

  has_one :account
  has_one :statistics

  # Scopes --------------------------------------------------------------------
  scope :accuracies, -> { where.not(accuracy: nil) }
  scope :news, -> { where(accuracy: nil) }

  scope :privated, -> { where(public: false) }
  scope :publics, -> { where(public: true) }
  scope :active, -> { where(enable: true) }
  scope :disabled, -> { where(enable: false) }
  scope :publishables, -> { where(publishable: true) }
  scope :not_publishables, -> { where(publishable: false) }

  scope :cron_active, -> { where(keep_cron_crawler: true) }
  scope :cron_disabled, -> { where(keep_cron_crawler: false) }

  scope :collect_at_asc, -> { order('collect_at asc') }
  scope :collect_at_desc, -> { order('collect_at desc') }

  scope :tf_idf_at_asc, -> { order('tf_idf_at asc') }
  scope :svm_rated_at_asc, -> { order('svm_rated_at asc') }
  scope :publish_at_asc, -> { order('publish_at asc') }

  scope :category_nil, -> { where(category: nil) }
  scope :category_technology, -> { where(category: "technology") }
  scope :category_entertainment, -> { where(category: "entertainment") }
  scope :category_person, -> { where(category: "person") }
  scope :category_politics, -> { where(category: "politics") }

  scope :order_by_word, -> { order(:word) }

  scope :five_days_ago, -> { where('created_at >= :five_days_ago', :five_days_ago  => Time.now - 5.days) } 

  # Accessors -----------------------------------------------------------------

  # Callbacks -----------------------------------------------------------------
  before_create do
    self.uuid = HumanUuid.new(word).call
  end

  after_create do
    self.create_statistics
  end

  # Methods -------------------------------------------------------------------

  def options_for_languages
    languages.map{ |l| [l.human_name, l.name] if l.human_name }.compact
  end

  def private_token?
    public == false
  end

  def prediction?
    if tweets.any?
      tweets.user_rated.count >= (tweets.count / 4)
    end
  end

  def can_predict?
    if prediction?
      svm_rated_at.nil? || svm_rated_at < collect_at
    end
  end

  def accuracy_human
    I18n.t("tweets.accuracy", percent: accuracy) if accuracy
  end

  def disable
    update(enable: false)
  end

  def revert_keep_cron_crawler
    update(keep_cron_crawler: !keep_cron_crawler)
  end

  def revert_enable
    update(enable: !enable)
  end

  def revert_privacity
    update(public: !public)
  end

  def revert_publishable
    publish_on_twitter_at = !publishable ? DateTime.current : nil
    update(publishable: !publishable, publish_at: publish_on_twitter_at)
  end

  def user
    company.users.first.username_or_email
  end
end
