class Contact < ActiveRecord::Base
  # Mixins

  # Constants

  # Associations

  # Validations
  validates :name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
  validates :message, presence: true, allow_blank: false

  # Scope
  scope :created_at_desc, -> { order('created_at desc') }

  # Accessors

  # Callbacks

  # Methods
end
