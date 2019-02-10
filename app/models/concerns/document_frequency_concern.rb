module DocumentFrequencyConcern
  extend ActiveSupport::Concern

  included do
    scope :order_by_df_desc, -> { order(df: :desc) }
  end

  def up_df
    ActiveRecord::Base.connection_pool.with_connection do
      update(df: self.df + 1)
    end
  end
end
