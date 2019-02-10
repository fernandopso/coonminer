class Company < ActiveRecord::Base
  # Mixins --------------------------------------------------------------------

  # Constants -----------------------------------------------------------------
  MAX_TOKENS = 5
  MAX_TWEETS = 20000

  ACTIVE = "active"
  SUSPENDED = "suspended"

  # Associations --------------------------------------------------------------
  has_many :users
  has_many :tokens

  # Accessors -----------------------------------------------------------------

  # Validations ---------------------------------------------------------------

  # Callbacks -----------------------------------------------------------------

  # Scopes --------------------------------------------------------------------

  # Methods -------------------------------------------------------------------
  def free?
    status == nil
  end

  def active?
    status == ACTIVE
  end

  def suspended?
    status == SUSPENDED
  end

  def set_active
    update(status: ACTIVE)
  end

  def set_suspended
    update(status: SUSPENDED)
  end
end
