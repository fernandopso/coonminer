class Contact < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
  validates :message, presence: true, allow_blank: false

  scope :created_at_desc, -> { order('created_at desc') }
end
