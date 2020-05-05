class Word < ActiveRecord::Base
  include DocumentFrequencyConcern
  include BannableConcern
end
