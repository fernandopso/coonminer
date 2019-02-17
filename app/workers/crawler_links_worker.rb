# frozen_string_literal: true

class CrawlerLinksWorker
  include Sidekiq::Worker

  def perform
    Category.first.tokens.each do |token|
      token.links.order_by_df_desc.take(3).each do |link|
        next unless link.href

        logger.info "Perform async to url #{link.href} of token #{token.uuid}"

        Links::TitleWorker.perform_async(link.href, link.id)
      end
    end
  end
end
