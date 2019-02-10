module BannableConcern
  extend ActiveSupport::Concern

  included do
    scope :banneds, -> { where(banned: true) }
    scope :actives, -> { where(banned: false) }
  end

  def ban
    update(banned: true)
  end

  def active
    update(banned: false)
  end
end
