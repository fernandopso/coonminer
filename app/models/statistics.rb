class Statistics < ActiveRecord::Base
  validates :token_id, presence: true
end
