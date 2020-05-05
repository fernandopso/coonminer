class Metric < ActiveRecord::Base
  validates :token_id, presence: true
end
