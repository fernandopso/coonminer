module TokensHelper

  def options_for_languages
    Constants::LANGUAGES.map do |lang|
      [t("languages.#{lang}"), lang]
    end
  end

  def options_for_categories
    Category.all.map do |category|
      [category.title, category.id]
    end
  end

  def options_order_tokens(selected)
    options_for_select([
      ['tf_idf_at'],
      ['svm_rated_at'],
      ['collect_at'],
      ['created_at'],
      ['publish_at']
    ], selected: selected)
  end

  def options_for_boolean(selected)
    options_for_select([
      [t('active'), 'active'],
      [t('disabled'), 'disabled']
    ], selected: selected)
  end


  def options_for_enable(selected)
    options_for_select([
      [t('filter.tokens_active'), 'active'],
      [t('filter.tokens_disabled'), 'disabled']
    ], selected: selected)
  end

  def title_for_token(token)
    t(
      'tokens.label_percent',
      count_positive: token.statistics.percent_positive, rate_positive: t('positive'),
      count_neutral:  token.statistics.percent_neutral,  rate_neutral:  t('neutral'),
      count_negative: token.statistics.percent_negative, rate_negative: t('negative')
    )
  end

end
