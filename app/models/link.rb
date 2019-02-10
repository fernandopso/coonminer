class Link < ActiveRecord::Base
  MINUTES = 60
  HOURS   = 24

  # Constants -----------------------------------------------------------------

  # Concerns ------------------------------------------------------------------
  include DocumentFrequencyConcern
  include BannableConcern

  # Validations ---------------------------------------------------------------

  # Associations --------------------------------------------------------------

  # Scopes --------------------------------------------------------------------

  # Accessors -----------------------------------------------------------------

  # Callbacks -----------------------------------------------------------------

  # Methods -------------------------------------------------------------------

  def human_title
    title ? title : href
  end

  def updated_at_to_human
    if updated_at_to_minutes < MINUTES
      I18n.t('links.updated_at_to_minutes_ago', minutes: updated_at_to_minutes)
    elsif updated_at_to_hours < HOURS
      I18n.t('links.updated_at_to_hours_ago', hours: updated_at_to_hours)
    else
      I18n.t('links.updated_at_to_days_ago', days: updated_at_to_days)
    end
  end

  private

  def updated_at_to_minutes
    TimeDifference.between(Time.now, updated_at).in_minutes.to_i
  end

  def updated_at_to_hours
    updated_at_to_minutes / 60
  end

  def updated_at_to_days
    updated_at_to_hours / 24
  end
end
