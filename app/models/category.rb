class Category < ActiveRecord::Base
  has_many :tokens
end
