class Company < ActiveRecord::Base
  MAX_TOKENS = 5
  MAX_TWEETS = 20000
  ACTIVE = "active"
  SUSPENDED = "suspended"

  has_many :users
  has_many :tokens

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
