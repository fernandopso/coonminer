module TweetsHelper
  def positive_params
    { tweet: { rate: Tweet::POSITIVE } }
  end

  def negative_params
    { tweet: { rate: Tweet::NEGATIVE } }
  end

  def neutral_params
    { tweet: { rate: Tweet::NEUTRAL } }
  end

  def rate_color_tag(option)
    case option
    when 'positive'
      'primary'
    when 'neutral'
      'warning'
    when 'negative'
      'danger'
    end
  end

  def rate_tag(rate)
    rate.present? ? t("#{rate}") : t('rate.not_rated')
  end

  def options_for_rate_of_tweets_rated(rate)
    options_for_select([
      [t('tweets.options_for_svm_rate.positive'), 'positive'],
      [t('tweets.options_for_svm_rate.negative'), 'negative'],
      [t('tweets.options_for_svm_rate.neutral'),  'neutral']
    ], selected: rate)
  end

  def options_for_rate(rate, type)
    options_for_select([
      [t('tweets.options_for_mining_index_page.positive'), "#{type}_positive"],
      [t('tweets.options_for_mining_index_page.negative'), "#{type}_negative"],
      [t('tweets.options_for_mining_index_page.neutral'),  "#{type}_neutral"],
      [t('tweets.options_for_mining_index_page.unrated'),  "#{type}_unrated"]
    ], selected: rate)
  end


  def options_filter_for_all_rates(selected)
    options_for_select([
      [t('tweets.options_for_filter_users.positive'),      'positive'],
      [t('tweets.options_for_filter_users.neutral'),       'neutral' ],
      [t('tweets.options_for_filter_users.negative'),      'negative'],
      [t('tweets.options_for_filter_users.user_positive'), 'user_positive'],
      [t('tweets.options_for_filter_users.user_neutral'),  'user_neutral' ],
      [t('tweets.options_for_filter_users.user_negative'), 'user_negative'],
      [t('tweets.options_for_filter_users.svm_positive'),  'svm_positive' ],
      [t('tweets.options_for_filter_users.svm_neutral'),   'svm_neutral'  ],
      [t('tweets.options_for_filter_users.svm_negative'),  'svm_negative' ]
    ], selected: selected)
  end

  def options_filter_date(selected)
    options_for_select([
      [t('tweets.options_for_filter_date.last_3_hours'),  '3H'],
      [t('tweets.options_for_filter_date.last_12_hours'), '12H'],
      [t('tweets.options_for_filter_date.last_24_hours'), '24H'],
      [t('tweets.options_for_filter_date.last_3_days'),   '3D'],
      [t('tweets.options_for_filter_date.last_7_days'),   '7D']
    ], selected: selected)
  end
end
