module TokenConcerns
  module Statusable
    extend ActiveSupport::Concern

    def collecting!
      update(status: 'collecting', collect_at: DateTime.current)
    end

    def collected!
      update(status: 'collected', collect_at: DateTime.current)
    end

    def collecting?
      status == 'collecting'
    end

    def collected?
      status == 'collected'
    end
  end
end
