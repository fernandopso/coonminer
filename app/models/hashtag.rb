class Hashtag < ActiveRecord::Base
  include DocumentFrequencyConcern

  def human_name
    name[1..-1]
  end
end
