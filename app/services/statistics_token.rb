class StatisticsToken
  ATTRS = %w[
    amount
    user_rated
    user_rated_positive
    user_rated_neutral
    user_rated_negative
    svm_rated
    svm_rated_positive
    svm_rated_neutral
    svm_rated_negative
    user_validate
    amount_rated
    positive
    neutral
    negative
    percent_positive
    percent_neutral
    percent_negative
    tweets_to_delete
    last_3_hours
    last_12_hours
    last_24_hours
    last_3_days
    last_7_days
  ]

  attr_accessor :token, :statistics

  def initialize(token)
    self.token = token
    self.statistics = token.statistics
  end

  def update
    token.update(accuracy: accuracy) if statistics.update(attributes)
  end

  private

  def attributes
    ATTRS.each_with_object({}) { |attr, hsh| hsh[attr] = send(attr) }
  end

  def amount
    token.tweets.count
  end

  def user_rated
    token.tweets.user_rated.count
  end

  def user_rated_positive
    token.tweets.user_rated.positive.count
  end

  def user_rated_neutral
    token.tweets.user_rated.neutral.count
  end

  def user_rated_negative
    token.tweets.user_rated.negative.count
  end

  def svm_rated
    token.tweets.svm_rated.count
  end

  def svm_rated_positive
    token.tweets.svm_rated.svm_positive.count
  end

  def svm_rated_neutral
    token.tweets.svm_rated.svm_neutral.count
  end

  def svm_rated_negative
    token.tweets.svm_rated.svm_negative.count
  end

  def user_validate
    token.tweets.validates_by_users.count
  end

  def amount_rated
    token.tweets.user_or_svm_rated.count
  end

  def positive
    token.tweets.user_or_svm_rated_positive.count
  end

  def neutral
    token.tweets.user_or_svm_rated_neutral.count
  end

  def negative
    token.tweets.user_or_svm_rated_negative.count
  end

  def percent_positive
    percent_positive
  end

  def percent_neutral
    percent_neutral
  end

  def percent_negative
    percent_negative
  end

  def tweets_to_delete
    token.tweets.not_rated.more_than_seven_days.count
  end

  def last_3_hours
    token.tweets.send('3h').count
  end

  def last_12_hours
    token.tweets.send('12h').count
  end

  def last_24_hours
    token.tweets.send('24h').count
  end

  def last_3_days
    token.tweets.send('3d').count
  end

  def last_7_days
    token.tweets.send('7d').count
  end

  def accuracy
    if token.tweets.validates_by_users.count > 0
      (token.tweets.validates_correct.count * 100) / token.tweets.validates_by_users.count
    end
  end

  def percent_positive
    if statistics.amount_rated.to_f > 0
      (statistics.positive * 100) / statistics.amount_rated.to_f
    end
  end

  def percent_neutral
    if statistics.amount_rated.to_f > 0
      (statistics.neutral * 100) / statistics.amount_rated.to_f
    end
  end

  def percent_negative
    if statistics.amount_rated.to_f > 0
      (statistics.negative * 100) / statistics.amount_rated.to_f
    end
  end
end
