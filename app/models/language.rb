class Language < ActiveRecord::Base
  include DocumentFrequencyConcern

  def human_name
    I18n.t("languages.#{name}") if I18n.t('languages').keys.include?(name.to_sym)
  end
end
