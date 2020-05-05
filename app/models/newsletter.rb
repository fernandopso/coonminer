class Newsletter < ActiveRecord::Base
  validates :email, presence: true, allow_blank: false

  belongs_to :token
end
