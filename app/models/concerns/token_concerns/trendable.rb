module TokenConcerns
  module Trendable
    extend ActiveSupport::Concern

    def top_hashtags
      hashtags.order_by_df_desc.take(50).map  { |t| { text: t.name, weight: t.df } }
    end

    def top_locations
      locations.order_by_df_desc.take(52).map { |t| { text: t.name, weight: t.df } if not %w[brasil brazil].include?(t.name.downcase) }.compact
    end

    def top_languages
      languages.order_by_df_desc.take(51).map { |t| { text: t.human_name, weight: t.df } if not %w[pt por].include?(t.name) }.compact
    end

    def top_mentions
      mentions.order_by_df_desc.take(50).map  { |t| { text: t.name, weight: t.df } }
    end

    def top_links(max = 3)
      links.order_by_df_desc.take(max)
    end

    def top_profiles
      profiles.order_by_df_desc.take(24)
    end
  end
end
